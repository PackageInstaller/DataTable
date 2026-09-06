-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameLevelView.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameLevelView", package.seeall)

local SphereGameLevelView = class("SphereGameLevelView", TableViewComponent)

function SphereGameLevelView:ctor()
	SphereGameLevelView.super.ctor(self)
end

function SphereGameLevelView:buildUI()
	SphereGameLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function SphereGameLevelView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function SphereGameLevelView:bindEvents()
	SphereGameLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SphereGameLevelView:unbindEvents()
	SphereGameLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SphereGameLevelView:onEnter()
	SphereGameLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ACGetRankInfoRes, self._onGetRankInfoRes, self)

	self._activityId = MakeCakeModel.instance:getActivityId()
	self._stagePlanId = MakeCakeModel.instance:getStagePlanId(self._activityId)

	local fromStage, toStage = self:_getStageFromTo()

	AnniversaryCakeAgent.instance:sendPM_ACGetRankInfoReq(self._activityId, fromStage, toStage)
end

function SphereGameLevelView:onExit()
	SphereGameLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGetRankInfoRes, self._onGetRankInfoRes, self)
end

function SphereGameLevelView:_onClickClose()
	self:close()
end

function SphereGameLevelView:_onReloadFinish()
	local maxStage = MakeCakeModel.instance:getMaxPassStageId()
	local index = 1

	for i, v in ipairs(self._curViewDatas) do
		if v.stage == maxStage then
			index = i
		end
	end

	self:moveCellToCenter(index)
end

function SphereGameLevelView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, SGLevelCell)

	component:init(data)
end

function SphereGameLevelView:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, SGLevelCell)

	component:clear()
end

function SphereGameLevelView:_onGetRankInfoRes()
	self:_initLevelList()
end

function SphereGameLevelView:_getStageFromTo()
	local stageList = MakeCakeConfig.instance:getStageCfgList(self._stagePlanId)

	return stageList[1].stage, stageList[#stageList].stage
end

function SphereGameLevelView:_initLevelList()
	local stageList = MakeCakeConfig.instance:getStageCfgList(self._stagePlanId)

	self:updateListData(stageList)
end

return SphereGameLevelView
