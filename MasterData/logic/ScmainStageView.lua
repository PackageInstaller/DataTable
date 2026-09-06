-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScmainStageView.lua

module("logic.extensions.scenariocopy.view.ScmainStageView", package.seeall)

local ScmainStageView = class("ScmainStageView", ViewComponent)
local StoryType = {
	btnStory1 = 1,
	openCopyMissionView = 3,
	btnStory2 = 2
}

function ScmainStageView:ctor()
	ScmainStageView.super.ctor(self)

	self._storyType = StoryType.openCopyMissionView
end

function ScmainStageView:buildUI()
	ScmainStageView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._txtProgress = self:getGo("main/top/txtProgress"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("main/top/txtDesc"):GetComponent(goutil.Type_UIText)
	self._starContainer = self:getGo("main/top/stars")
	self._txtRecmdPower = self:getGo("main/top/fightpower/txtRecmdPower"):GetComponent(goutil.Type_UIText)
	self._perfectPass = self:getGo("main/top/perfectPass")
	self._passCondition = self:getGo("main/top/passCondition")
	self._passConditionPos1 = self:getGo("main/top/passConditionPos1")
	self._btnAuto = self:getBtn("main/bottom/btnAuto")
	self._btnStart = self:getBtn("main/bottom/btnStart")
	self._txtStart = goutil.findChild(self._btnStart, "Text"):GetComponent(goutil.Type_UIText)
	self._costPower = self:getGo("main/bottom/costPower")
	self._txtCostNum = self:getGo("main/bottom/costPower/txtCostNum"):GetComponent(goutil.Type_UIText)
	self._txtBtnStartName = self:getGo("main/bottom/btnStart/Text"):GetComponent(goutil.Type_UIText)
	self._iconPower = self:getGo("main/bottom/costPower/Image")
	self._tableGo = self:getGo("main/bottom/rewardList")
	self._tableCell = self:getGo("main/bottom/rewardList/item")
	self._tableview = ScrollerList.create(self._tableGo, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableCell:SetActive(false)

	self._txtPassDesc = self:getTxt("main/top/passCondition/condition1/txtPassDesc")
end

function ScmainStageView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAuto:AddClickListener(self._onClickSweep, self)
end

function ScmainStageView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
end

function ScmainStageView:onEnter()
	ScmainStageView.super.onEnter(self)

	self._stageCfg = self:getOpenParam()[1]
	self._viewName = self:getOpenParam()[2]

	self:_setBlurBg()
	self:_refresh()
end

function ScmainStageView:onExit()
	ScmainStageView.super.onExit(self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._iconPower)
end

function ScmainStageView:_refresh()
	if self._stageCfg then
		self._btnAuto.gameObject:SetActive(false)

		self._txtPassDesc.text = self._stageCfg.passDesc
		self._txtDesc.text = self._stageCfg.desc
		self._txtRecmdPower.text = self._stageCfg.recommendZdl

		local isPass = ScenariocopyModel.instance:getStagePass(self._stageCfg.chapterId, self._stageCfg.stageId)
		local matType, id, matNum = MaterialMgr.getMatParams(self._stageCfg.energyConsume)

		self._costPower.gameObject:SetActive(checknumber(matNum) > 0 and not isPass)

		if not string.nilorempty(self._stageCfg.energyConsume) then
			local matCfg = MaterialMgr.getMatCfgByStr(self._stageCfg.energyConsume)

			uGuiUtil.setSpriteToImage(self._iconPower, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
		end

		self._txtCostNum.text = matNum

		local chapterCfg = ScenariocopyModel.instance:getChapterCfg()

		if chapterCfg then
			self._txtProgress.text = chapterCfg.chapterName
		end

		self:_setBtnStart(isPass)
		self:_updateRewardList()
	end
end

function ScmainStageView:_setBtnStart(isPass)
	self._txtBtnStartName.text = isPass and ((self._stageCfg.beforeBattleId > 0 or self._stageCfg.afterBattleId > 0) and "剧情回顾" or "本关已通关") or "前往挑战"
end

function ScmainStageView:_onClickStart()
	if ScenariocopyModel.instance:getStagePass(self._stageCfg.chapterId, self._stageCfg.stageId) then
		if self._stageCfg.beforeBattleId > 0 or self._stageCfg.afterBattleId > 0 then
			if self._stageCfg.beforeBattleId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._stageCfg.beforeBattleId, StoryModel.StoryType.SCCopy)
			end

			if self._stageCfg.afterBattleId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._stageCfg.afterBattleId, StoryModel.StoryType.SCCopy)
			end
		else
			FloatWordMgr.instance:show(lang("本关已通关"))
		end
	else
		ScenariocopyController.instance:enterMissionOrStory(self._stageCfg, self._viewName)
	end
end

function ScmainStageView:_updateRewardList()
	local comRewardStr = string.split(self._stageCfg.comReward, "#")
	local rewardList = {}

	for k, v in pairs(comRewardStr) do
		local single = {}

		single.reward = v
		single.shouTong = false

		table.insert(rewardList, single)
	end

	self._tableview:reloadData(rewardList)
end

function ScmainStageView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.setCellByCfg(data.reward, icon)

	local goShouTong = goutil.findChild(cell, "shouTong")

	goShouTong.gameObject:SetActive(data.shouTong)
end

function ScmainStageView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function ScmainStageView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function ScmainStageView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function ScmainStageView:_onClickClose()
	self:close()
end

function ScmainStageView:_onClickSweep()
	MopupModel.instance:cliclkOperationPlotSweep(self._stageCfg.chapterId, self._stageCfg.stageId)
end

return ScmainStageView
