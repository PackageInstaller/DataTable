-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameResultView.lua

module("logic.extensions.orimatgame.view.OriMatGameResultView", package.seeall)

local OriMatGameResultView = class("OriMatGameResultView", ViewComponent)

function OriMatGameResultView:buildUI()
	OriMatGameResultView.super.buildUI(self)

	self._txtCurRecord = self:getTxt("curRecord/txt")
	self._txtBestRecord = self:getTxt("bestRecord/txt")
	self._btnSure = self:getGo("btnSure")

	local itemScrCell = self:getGo("itemCol/scrCell")
	local itemScrView = self:getGo("itemCol/scrView")

	self._itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function OriMatGameResultView:bindEvents()
	OriMatGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickBtnSure, self, true))
end

function OriMatGameResultView:unbindEvents()
	OriMatGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriMatGameResultView:onEnter()
	OriMatGameResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._isPass = checkbool(params[3])
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameEndRes, self._handlePM_OriginMaterialGameEndRes, self)

	self._curWave, self._totalWave = OriMatGameGameController.instance:getCurWave()

	if not self._isPass then
		self._curWave = Mathf.Max(0, self._curWave - 1)
	end

	OriMatGameController.instance:sendPM_OriginMaterialGameEndReq(self._seasonId, self._stageId, self._isPass, self._curWave)
	self:_onUpdate()
end

function OriMatGameResultView:onExit()
	OriMatGameResultView.super.onExit(self)
	self._itemScrollerList:dispose()
end

function OriMatGameResultView:_handlePM_OriginMaterialGameEndRes(status, msg)
	if status == 0 then
		return
	end

	self:_closeGame()
end

function OriMatGameResultView:_onUpdate()
	self._txtCurRecord.text = string.format("%s波", self._curWave)

	local bestWave = self._subMo:getStageWaveById(self._stageId)

	bestWave = Mathf.Max(bestWave, self._curWave)
	self._txtBestRecord.text = string.format("%s波", bestWave)

	local weaponIdList = OriMatGameGameController.instance:getSelectedWeaponIds()

	self._itemScrollerList:reloadData(weaponIdList)
end

function OriMatGameResultView:_updateItemCell(view, cell, weaponId, tag)
	local data = OriMatGameConfig.instance:getWeaponCfg(weaponId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local spriteChange = GameUtil.getUIImageSpriteChange(icon)

	spriteChange:ChangeSprite(data.weaponPic)
	icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.addClickHandler(mainGo, function()
		UIStateManager.instance:push(ViewName.OriMatGameWeaponTipsWinView, weaponId)
	end)
end

function OriMatGameResultView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(mainGo)
end

function OriMatGameResultView:_onClickBtnSure()
	self:_closeGame()
end

function OriMatGameResultView:_closeGame()
	self:close()
	UIStateManager.instance:popByName(ViewName.OriMatGameGameView)
end

return OriMatGameResultView
