local delay = 1  -- in seconds
local new_timer = ngx.timer.at
local log = ngx.log
local ERR = ngx.ERR
local check
local f
local preTime
check = function(premature)
    if not premature then
        if preTime==nil
        then
            preTime=os.date("%Y%m%d%H")
            logFile=string.format("logs/access.log")
        end
        
        if preTime~=os.date("%Y%m%d%H")
        then
            logFile=string.format("logs/access.log.%s",preTime)
            preTime=os.date("%Y%m%d%H")
        end
        f=io.open(logFile,"r")
        if f~=nil
        then
            io.close(f)
        else
            f=io.open("logs/access.log","r")
            if f~=nil
            then
                os.execute(string.format("mv logs/access.log %s",logFile))
                os.execute(string.format("kill -USR1 %d",masterPid))
            end
        end   
       local ok, err = new_timer(delay, check)
       if not ok then
           log(ERR, "failed to create timer: ", err)
           return
       end
   end
end
if 0 == ngx.worker.id() then
    local pid = ngx.worker.pid()
    log(ERR, string.format("master pid:%d this worker pid:%d ",masterPid,pid), err)
    local hdl, err = new_timer(delay, check)
    if not hdl then
        log(ERR, "failed to create timer: ", err)
        return
    end
end
