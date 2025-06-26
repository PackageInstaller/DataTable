local Authority = {}

--0普通玩家 1测试 2vip级测试 3金卡测试

-- 获取权限等级
Authority.GetAuthLevel = function(self)
    local session_component = Game.Scene:GetComponent("SessionComponent")
    if session_component ~= nil and session_component.permission ~= nil then
        return session_component.permission
    end
    if Game.Scene ~= nil and Game.Scene.Player ~= nil then
        return Game.Scene.Player.AuthLevel or -1
    end
    return -1
end

-- 获取日志权限
Authority.GetLogAuth = function(self, level)
    if CS.UnityEngine.Application.isEditor then
        return true
    end
    level = level or self:GetAuthLevel()
    if level <= 0 then
        return false
    end
    return true
end

-- 获取Report权限
Authority.GetReportAuth = function(self, level)
    if CS.UnityEngine.Application.isEditor then
        return true
    end
    level = level or self:GetAuthLevel()
    if level <= 0 then
        return false
    end
    return true
end

-- 切换账号权限
Authority.GetChangeAccountAuth = function(self, level)
    if CS.UnityEngine.Application.isEditor then
        return true
    end
    level = level or self:GetAuthLevel()
    if level <= 0 then
        return false
    end
    return true
end

-- 获取测试权限
Authority.GetTestAuth = function(self, level)
    if CS.UnityEngine.Application.isEditor then
        return true
    end
    level = level or self:GetAuthLevel()
    if level <= 0 then
        return false
    end
    return true
end

return Authority