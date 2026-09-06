-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianStageView.lua

module("logic.extensions.goddishitian.view.GodDiShiTianStageView", package.seeall)

local GodDiShiTianStageView = class("GodDiShiTianStageView", ViewComponent)

function GodDiShiTianStageView:ctor()
	GodDiShiTianStageView.super.ctor(self)
end

function GodDiShiTianStageView:buildUI()
	GodDiShiTianStageView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtScore = self:getTxt("scoreboard/txtScore")
	self._txtRule = self:getTxt("scoreboard/txtRule")
	self._clickItems = {}

	for i = 1, 4 do
		local item = {}

		item.btn = self:getBtn(string.format("btnStage_%d", i))
		item.txtState = self:getTxt(string.format("btnStage_%d/txtState", i))
		item.txtScore = self:getTxt(string.format("btnStage_%d/txtScore", i))

		table.insert(self._clickItems, item)
	end

	self._detailCustomInput = UICustomInput.Get(self:getGo("scoreboard/btnDetail"))
	self._tip = self:getGo("scoreboard/btnDetail/detailTip")
	self._bg = self:getGo("bg")
	self._txtTipTitle = self:getTxt("scoreboard/btnDetail/detailTip/txt")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtLine1 = self:getTxt("scoreboard/txtLine1")
	self._txtLine2 = self:getTxt("scoreboard/txtLine2")
	self.scrollerGo = self:getGo("scoreboard/btnDetail/detailTip/scrollview")
	self.cellGo = self:getGo("scoreboard/btnDetail/detailTip/cell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:regGetCellSize(function()
		return 217.4, 30
	end)
end

function GodDiShiTianStageView:bindEvents()
	GodDiShiTianStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)

	for i = 1, 4 do
		self._clickItems[i].btn:AddClickListener(function()
			self:_onClickItem(i)
		end)
	end

	self._detailCustomInput:AddListener(self._onClickDetailTip, self)
end

function GodDiShiTianStageView:unbindEvents()
	GodDiShiTianStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()

	for i = 1, 4 do
		self._clickItems[i].btn:RemoveClickListener()
	end

	self._detailCustomInput:RemoveListener()
end

function GodDiShiTianStageView:onEnter()
	GodDiShiTianStageView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetInfoRes, self)

	local param = self:getOpenParam()

	self._stageType = param[1]
	self._enterType = param[2] or 1
	self._challengeId = GodDiShiTianModel.instance:getChallengeId()
	self._cfgList = GodDiShiTianConfig.instance:getStageTypeInfoList(self._stageType)
	self._cfgStageType = GodDiShiTianConfig.instance:getStageTypeCfg(self._stageType)
	self._curSelectLevel = 1

	self:_loadBgImage()
	self:_initGameObject()
	self:_initTip()
	self:_updateShow()
	GodDiShiTianAgent.instance:sendPM_GodDiShiTianGetInfoReq()
end

function GodDiShiTianStageView:onExit()
	GodDiShiTianStageView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetInfoRes, self)
	uGuiUtil.clearImage(self._bg)
	self.scrollList:dispose()
end

function GodDiShiTianStageView:_onClickClose()
	self:close()
end

function GodDiShiTianStageView:_onClickChallenge()
	local customFmtMo = GodDiShiTianModel.instance:getCustomFmtMo()

	customFmtMo:initParams(self._challengeId, self._cfgList[self._curSelectLevel], self._stageType, self._enterType)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function GodDiShiTianStageView:_onClickDetailTip(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function GodDiShiTianStageView:_onClickItem(index)
	self._curSelectLevel = index

	self:_onClickChallenge()
end

function GodDiShiTianStageView:_onGetInfoRes()
	self:_updateShow()
end

function GodDiShiTianStageView:_initGameObject()
	goutil.setActive(self._tip, false)
end

function GodDiShiTianStageView:_updateShow()
	local cfgStageType = self._cfgStageType

	if not cfgStageType then
		return
	end

	local curScore = GodDiShiTianModel.instance:getChapterScore(self._stageType)

	if curScore >= cfgStageType.passLine then
		if not ColorConst.Green then
			local colorStr = ColorConst.Red

			self._txtScore.text = string.format("当前：<color=#%s>%d</color>/%d", colorStr, curScore, cfgStageType.passLine)

			local stageInfo = GodDiShiTianModel.instance:getChapterInfo(self._stageType)

			if stageInfo then
				for i, v in ipairs(stageInfo) do
					local cfgInfo = GodDiShiTianConfig.instance:getStageTypeInfoCfg(self._stageType, v.stageId)

					self._clickItems[i].txtScore.text = string.format("评分：%d", v.score)
					self._clickItems[i].txtState.text = v.state == GodDiShiTianModel.StageState.ChallengeSuccess and string.format("<color=#%s>%s</color>", ColorConst.Green, "挑战成功") or v.state == GodDiShiTianModel.StageState.ChallengeFail and string.format("<color=#%s>%s</color>", ColorConst.Red, "挑战失败") or "未挑战"
				end
			else
				for i = 1, 4 do
					self._clickItems[i].txtScore.text = string.format("评分：%d/%d", 0, 0)
					self._clickItems[i].txtState.text = "未挑战"
				end
			end
		end
	end
end

function GodDiShiTianStageView:_loadBgImage()
	local cfg = self._cfgStageType

	if cfg then
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(cfg.bgPath))
	end
end

function GodDiShiTianStageView:_initTip()
	self._txtTitle.text = self._cfgStageType.viewTitle
	self._txtTipTitle.text = self._cfgStageType.titleDesc
	self._txtLine1.text = self._cfgStageType.desc
	self._txtLine2.text = string.format("大于等于<color=#%s>%d</color>分", ColorConst.Green, self._cfgStageType.passLine)

	local list = {}
	local cfgs = GodDiShiTianConfig.instance:getChallengeScoreList(self._cfgList[1].scorePlanId)

	for i, v in pairs(cfgs) do
		local count = #v.scoreShow

		if count % 2 == 0 then
			for i = 1, count / 2 do
				local element = {}

				element.key = v.scoreShow[i * 2 - 1]
				element.value = v.scoreShow[i * 2]

				table.insert(list, element)
			end
		end
	end

	self.scrollList:reloadData(list)
end

function GodDiShiTianStageView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	txtDesc.text = data.key
	txtScore.text = data.value
end

function GodDiShiTianStageView:_clearCell(cell)
	return
end

return GodDiShiTianStageView
