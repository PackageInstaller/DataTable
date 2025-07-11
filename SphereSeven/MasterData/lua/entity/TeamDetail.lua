---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/4 14:48
--- 队伍的占位和Card数据


local TeamDetail = BaseClass("TeamDetail",Entity);
local base = Entity

local function Awake(self,teamDetailInfo)
    base.Awake(self)
    if teamDetailInfo ~= nil then
        self.CardId = teamDetailInfo.CardId
        self.MatrixPos = teamDetailInfo.MatrixPos
        self.IsSupport = teamDetailInfo.IsSupport or false --是否是使用别人的角色
    end
end

local function Dispose(self)
    base.Dispose(self)
end

TeamDetail.Awake = Awake
TeamDetail.Dispose = Dispose

return TeamDetail