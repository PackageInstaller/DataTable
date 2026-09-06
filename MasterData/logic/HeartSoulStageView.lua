-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/heartsoul/HeartSoulStageView.lua

module("logic.extensions.scenariocopy.view.heartsoul.HeartSoulStageView", package.seeall)

local HeartSoulStageView = class("HeartSoulStageView", ViewComponent)
local StoryType = {
	btnStory1 = 1,
	openCopyMissionView = 3,
	btnStory2 = 2
}

function HeartSoulStageView:ctor()
	HeartSoulStageView.super.ctor(self)

	self._storyType = StoryType.openCopyMissionView
end

function HeartSoulStageView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._UIChangeGroup = self:getGo("changeGroup"):GetComponent("UIChangeGroup")
	self._bg = self:getGo("bg")
	self._txtProgress = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("condition/txtDesc"):GetComponent(goutil.Type_UIText)
	self._txtRecmdPower = self:getGo("fightpower/txtRecmdPower"):GetComponent(goutil.Type_UIText)
	self._btnAuto = self:getBtn("btnAuto")
	self._btnStart = self:getBtn("btnStart")
	self._costPower = self:getGo("costPower")
	self._txtCostNum = self:getGo("costPower/txtCostNum"):GetComponent(goutil.Type_UIText)
	self._txtBtnStartName = self:getGo("btnStart/Text"):GetComponent(goutil.Type_UIText)
	self._iconPower = self:getGo("costPower/Icon")
	self._tableGo = self:getGo("normalPrize/tableview")
	self._tableCell = self:getGo("normalPrize/tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableCell:SetActive(false)

	self._txtPassDesc = self:getTxt("condition2/txtDesc")
	self._btnSpecialStart = self:getBtn("btnSpecialStart")
end

function HeartSoulStageView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAuto:AddClickListener(self._onClickSweep, self)
	self._btnSpecialStart:AddClickListener(self._onClickStart, self)
end

function HeartSoulStageView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
	self._btnSpecialStart:RemoveClickListener()
end

function HeartSoulStageView:onEnter()
	HeartSoulStageView.super.onEnter(self)

	self._stageCfg = self:getOpenParam()[1]
	self._viewName = self:getOpenParam()[2]
	self._chapterIndex = checknumber(self:getOpenParam()[3])

	self:_setChangeGroup()
	self:_setBg()
	self:_setBlurBg()
	self:_refresh()
end

function HeartSoulStageView:onExit()
	HeartSoulStageView.super.onExit(self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._iconPower)
	uGuiUtil.clearImage(self._bg)
end

function HeartSoulStageView:_refresh()
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

function HeartSoulStageView:_setBtnStart(isPass)
	self._txtBtnStartName.text = isPass and ((self._stageCfg.beforeBattleId > 0 or self._stageCfg.afterBattleId > 0) and "剧情回顾" or "本关已通关") or "前往挑战"

	self._btnSpecialStart.gameObject:SetActive(not isPass)
	self._btnStart.gameObject:SetActive(isPass)
end

function HeartSoulStageView:_onClickStart()
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

function HeartSoulStageView:_updateRewardList()
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

function HeartSoulStageView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.setCellByCfg(data.reward, icon)

	local goShouTong = goutil.findChild(cell, "shouTong")

	goShouTong.gameObject:SetActive(data.shouTong)
end

function HeartSoulStageView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function HeartSoulStageView:_setChangeGroup()
	self._UIChangeGroup:SetState(self._chapterIndex - 1)
end

function HeartSoulStageView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function HeartSoulStageView:_setBg()
	bgPath = {
		"ui/bigbg/yyfb/board_xxnn_01.png",
		"ui/bigbg/yyfb/board_xxnn_02.png",
		"ui/bigbg/yyfb/board_xxnn_03.png"
	}

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgPath[self._chapterIndex])
end

function HeartSoulStageView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function HeartSoulStageView:_onClickClose()
	self:close()
end

function HeartSoulStageView:_onClickSweep()
	MopupModel.instance:cliclkOperationPlotSweep(self._stageCfg.chapterId, self._stageCfg.stageId)
end

return HeartSoulStageView
