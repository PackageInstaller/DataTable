-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacechallengeView.lua

module("logic.extensions.nineplace.view.NineplacechallengeView", package.seeall)

local NineplacechallengeView = class("NineplacechallengeView", TableViewComponent)

function NineplacechallengeView:ctor()
	NineplacechallengeView.super.ctor(self)

	self.processInfos = {}
end

function NineplacechallengeView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function NineplacechallengeView:buildUI()
	NineplacechallengeView.super.buildUI(self)

	self.closeBtn = self:getBtn("winCon/closeBtn")
	self.txtName = self:getTxt("winCon/txtName")
	self.iconFor = self:getGo("btnShowTip/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.markLockTip = self:getGo("btnShowTip/markUnlock")
	self.txtForName = self:getTxt("btnShowTip/txtForName")
	self.roleCon = self:getGo("roleCon")
	self.tipBtn = self:getBtn("winCon/tipBtn")
	self.btnShowTip = self:getBtn("btnShowTip")
	self.btnLvup = self:getBtn("btnLvup")
end

function NineplacechallengeView:bindEvents()
	NineplacechallengeView.super.bindEvents(self)
	self.tipBtn:AddClickListener(self.onClickTip, self)
	self.closeBtn:AddClickListener(self.onClickClose, self)
	self.btnShowTip:AddClickListener(self.onClickShowTip, self)
	self.btnLvup:AddClickListener(self.onClickBtnLvup, self)
end

function NineplacechallengeView:unbindEvents()
	NineplacechallengeView.super.unbindEvents(self)
	self.tipBtn:RemoveClickListener()
	self.closeBtn:RemoveClickListener()
	self.btnShowTip:RemoveClickListener()
	self.btnLvup:RemoveClickListener()
end

function NineplacechallengeView:destroyUI()
	NineplacechallengeView.super.destroyUI(self)
end

function NineplacechallengeView:onEnter()
	NineplacechallengeView.super.onEnter(self)

	self.isInitOper = true

	GlobalDispatcher:addListener(NinePlaceModel.BattleEnd, self.initView, self)
	GlobalDispatcher:addListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
	NinePlaceController.instance:sendPM_GetNinePlaceProcessInfoReq()
	self:initView()
end

function NineplacechallengeView:onEnterFinished()
	NineplacechallengeView.super.onEnterFinished(self)
end

function NineplacechallengeView:onExit()
	if self.roleObj then
		RoleObjectPool.instance:removeRole(self.roleObj)

		self.roleObj = nil
	end

	NineplacechallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(NinePlaceModel.BattleEnd, self.initView, self)
	GlobalDispatcher:removeListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
end

function NineplacechallengeView:onExitFinished()
	NineplacechallengeView.super.onExitFinished(self)
end

function NineplacechallengeView:initView()
	local stageId = self:getFirstParam()

	if not stageId then
		printInfo("not stageId----------------")

		return
	end

	self.currStageId = stageId

	local cfg = NinePlaceConfig.instance:getStageCfgById(stageId)

	self.iconFor:SetState(stageId - 1)

	self.txtName.text = lang(cfg.name .. "法挑战")
	self.txtForName.text = lang(cfg.name .. "法")
	self.processInfo = NinePlaceModel.instance:getNinePlaceProcessInfo(stageId)
	self._curViewDatas = NinePlaceConfig.instance:getMonstersCfgByStageId(stageId)

	self:reloadData()
	self:showRole(cfg.raceId)

	if self.processInfo and self.processInfo.masterIdx then
		local isUnlock = self.processInfo.masterIdx > 0

		goutil.setActive(self.markLockTip, isUnlock)
	end
end

function NineplacechallengeView:showRole(raceId)
	local list = CharacterConfig.instance:getModelUIPosAndScale("nineplacechallenge", raceId)

	self.roleObj = RoleObjectPool.instance:addRoleToParent(self.roleObj, raceId, self.roleCon.transform, list[3], nil, true, list[1], list[2])
end

function NineplacechallengeView:_updateCell(view, cell, cfg)
	local component = GameUtil.AddLuaOnce(cell.gameObject, NinePlaceChallengeItem)

	component:setData(self.currStageId, cfg.creepsMasterId, self.processInfo, cell.data)
end

function NineplacechallengeView:_cellSize()
	return 100, 110
end

function NineplacechallengeView:_onReloadFinish()
	if self.isInitOper then
		self.isInitOper = false

		local index = false
		local stageId = self:getFirstParam()

		for i, v in ipairs(self._curViewDatas) do
			if NinePlaceModel.instance:isMonsterCanChallenge(stageId, v.creepsMasterId) then
				index = i

				break
			end
		end

		if index then
			self._tableview:ForceMoveCellToCenter(index)
		end
	end
end

function NineplacechallengeView:onClickClose()
	self:close()
end

function NineplacechallengeView:onClickTip()
	TipsFacade.instance:openRulesView("nineplacebattle")
end

function NineplacechallengeView:onClickShowTip()
	UIStateManager.instance:push(ViewName.NineplaceshowtipView, self.currStageId)
end

function NineplacechallengeView:onClickBtnLvup()
	UIStateManager.instance:push(ViewName.NineplacelvupView, self.currStageId)
end

return NineplacechallengeView
