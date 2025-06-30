local MockManager = BaseClass("MockManager", Singleton);

local _msgHandlerMap
local _mockers

local function __init(self)
    local mockList = require "_Mock.MockList"
    _msgHandlerMap = {}
    _mockers = {}
    for _, mockName in ipairs(mockList) do
        local mockPath = string.format("_Mock.%sMock", mockName)
        local mock = require(mockPath)
        mock:GetInstance()
        _mockers[mockName] = mock
    end
end

local function __delete(self)
    _msgHandlerMap = nil
    _mockers = nil
end

local function HandleMsg(self, msgId, msg)
    local handler = _msgHandlerMap[msgId]
    -- assert(handler ~= nil, "no msg handler for msgId: " .. msgId)
    if handler == nil then
        Logger.Log("msgId is not handled by mock: " .. msgId)
        return nil
    end
    return handler(msg)
end

local function RegisterMsgHandler(self, msgId, handler)
    assert(msgId ~= nil, "messageId is nil")
    assert(handler ~= nil, "handler is nil")
    assert(_msgHandlerMap[msgId] == nil, "msgId has been registered: " .. msgId)
    _msgHandlerMap[msgId] = handler
end

local function GetMock(mockName)
    return _mockers[mockName]
end

MockManager.__init = __init
MockManager.__delete = __delete
MockManager.HandleMsg = HandleMsg
MockManager.RegisterMsgHandler = RegisterMsgHandler
MockManager.GetMock = GetMock

return MockManager;