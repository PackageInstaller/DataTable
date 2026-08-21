local OtakuRoomByComposeData = BaseClass("OtakuRoomByComposeData", require("DataCenter.Otaku.BaseOtakuRoomData"))
local M = OtakuRoomByComposeData


-- 是否完成 名字统一 方便调用
function M:IsEnd()
    return false
end

-- 额外附加数据
function M:ExtraData(data)
    
end

function M:OnInit() 
end

function M:OnUpdate(netUpdateType)
end

function M:OnDestory()
end


return OtakuRoomByComposeData
