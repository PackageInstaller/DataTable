-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialDialogueView.lua

module("logic.extensions.dualtrial.view.DualTrialDialogueView", package.seeall)

local DualTrialDialogueView = class("DualTrialDialogueView", ViewComponent)

function DualTrialDialogueView:ctor()
	DualTrialDialogueView.super.ctor(self)
end

function DualTrialDialogueView:unbindEvents()
	DualTrialDialogueView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFinish)
	GameUtil.rmClickHandler(self._btnClose)
end

function DualTrialDialogueView:bindEvents()
	DualTrialDialogueView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickBtnFinish, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DualTrialDialogueView:buildUI()
	DualTrialDialogueView.super.buildUI(self)

	self._sv = self:getGo("sv")
	self._petcard = self:getGo("petcard")
	self._txt = self:getTxt("sv/Viewport/txt")
	self._btnFinish = self:getGo("btnFinish")
	self._btnClose = self:getGo("btnClose")
	self._replayCol = self:getGo("replayCol")
	self._scrCell = self:getGo("replayCol/scrCell")
	self._scrView = self:getGo("replayCol/scrView")
	self._tableview = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._svHeight = GameUtil.getHeight(self._sv)
end

function DualTrialDialogueView:onExit()
	DualTrialDialogueView.super.onExit(self)
	uGuiUtil.clearImage(self._petcard)
	removetimer(self._updateTxtPos, self)
end

function DualTrialDialogueView:onEnter()
	DualTrialDialogueView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DualTrialEndEvent, self._handleEndEvent, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._eventCfg = params[2]
	self._curDialogueId = self._eventCfg.dialogueId
	self._lastContentId = 1
	self._txt.text = ""

	local faceId = self._eventCfg.showLihui
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(self._petcard, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._actCfg = DualTrialConfig.instance:getActivityCfgById(self._activityId)

	self:_updateUIByInfo()
end

function DualTrialDialogueView:_updateUIByInfo()
	goutil.setActive(self._btnFinish, false)
	goutil.setActive(self._replayCol, false)

	local contentCfg = DualTrialConfig.instance:getDialogueCfgById(self._curDialogueId, self._lastContentId)

	self._txt.text = GameUtil.isEmptyString(self._txt.text) and contentCfg.content or self._txt.text .. "\n\n" .. contentCfg.content

	if contentCfg.autoNext > 0 then
		self._lastContentId = contentCfg.autoNext

		self:_updateUIByInfo()
	elseif contentCfg.isEnd == 1 then
		goutil.setActive(self._btnFinish, true)
	else
		goutil.setActive(self._replayCol, true)

		local curDataList = {}

		if not contentCfg.waitAnswer then
			for _, id in ipairs(contentCfg.waitAnswer) do
				table.insert(curDataList, DualTrialConfig.instance:getDialogueCfgById(self._curDialogueId, id))
			end

			self._tableview:reloadData(curDataList)
		end
	end

	settimer(0.1, self._updateTxtPos, self, false)
end

function DualTrialDialogueView:_updateCell(view, cellGo, data)
	GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickSelect, self, data))

	local txt = goutil.findChildTextComponent(cellGo, "txtDesc")

	txt.text = data.desc
end

function DualTrialDialogueView:_clearCell(cellGo)
	GameUtil.rmClickHandler(cellGo)
end

function DualTrialDialogueView:_onClickSelect(data)
	self._lastContentId = data.id

	self:_updateUIByInfo()
end

function DualTrialDialogueView:_updateTxtPos()
	if self._lastContentId == 1 then
		-- block empty
	else
		local curHeight = GameUtil.getHeight(self._txt.gameObject)

		if curHeight > self._svHeight then
			GameUtil.setAnchoredPos(self._txt.gameObject, 0, curHeight - self._svHeight)
		end
	end
end

function DualTrialDialogueView:_onClickBtnFinish()
	DualTrialController.instance:endEvent(self._activityId)
end

function DualTrialDialogueView:_handleEndEvent()
	self:close()
	DualTrialController.instance:onepEventView(self._activityId, true)
end

return DualTrialDialogueView
