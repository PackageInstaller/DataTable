-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/view/WuShenPreWuShenPreFmtView.lua

module("logic.extensions.wushenshou.view.WuShenPreWuShenPreFmtView", package.seeall)

local WuShenPreWuShenPreFmtView = class("WuShenPreWuShenPreFmtView", MissionFmtView)

function WuShenPreWuShenPreFmtView:ctor()
	WuShenPreWuShenPreFmtView.super.ctor(self)
end

function WuShenPreWuShenPreFmtView:onEnter()
	self._shenshouType = self:getFirstParam() or 1

	WuShenPreWuShenPreFmtView.super.onEnter(self)
end

function WuShenPreWuShenPreFmtView:_getCreepCos()
	local pveId = self._shenshouType

	return (WuShenConfig.instance:getCfgById(pveId))
end

function WuShenPreWuShenPreFmtView:_getMonsterCo()
	local pveId = self._shenshouType

	return (WuShenConfig.instance:getMasterCoById(pveId))
end

function WuShenPreWuShenPreFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return WuShenPreWuShenPreFmtView
