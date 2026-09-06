-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgExtremeView.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgExtremeView", package.seeall)

local DivineFuYaoClgExtremeView = class("DivineFuYaoClgExtremeView", ViewComponent)
local CurStageId = 0

function DivineFuYaoClgExtremeView:buildUI()
	DivineFuYaoClgExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell1 = self:getGo("stageCol/scrCell1")
	local stageScrCell2 = self:getGo("stageCol/scrCell2")
	local scrCellList = {
		stageScrCell1,
		stageScrCell2
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._stageScrollerList = ScrollerList.create(stageScrView, scrCellList, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._stageScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._itemPrize = self:getGo("prize/item")
	self._tagHasGain = self:getGo("prize/tagHasGain")
	self._btnReset = self:getGo("btnReset")
	self._txtTips = self:getTxt("tips/txt")
	self._buffTips = self:getGo("buffTips")
	self._btnShowBuff = self:getGo("btnShowBuff")

	local buffScrCell = self:getGo("buffTips/scrCell")
	local buffScrView = self:getGo("buffTips/scrView")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function DivineFuYaoClgExtremeView:bindEvents()
	DivineFuYaoClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnShowBuff, self._onClickBtnShowBuff, self)
end

function DivineFuYaoClgExtremeView:unbindEvents()
	DivineFuYaoClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnShowBuff)
end

function DivineFuYaoClgExtremeView:onEnter()
	DivineFuYaoClgExtremeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)
	self._actData = DivineFuYaoClgConfig.instance:getActivityData(self._activityId)
	self._curStageId = CurStageId or 0

	MaterialMgr.setCellByCfg(self._actData.extremePrize, self._itemPrize)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineFuYaoClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineFuYaoClgExtremeResetRes, self._onUpdate, self)
	self:_onUpdate()

	local changeSetId = self._subMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function DivineFuYaoClgExtremeView:onExit()
	DivineFuYaoClgExtremeView.super.onExit(self)

	CurStageId = self._curStageId

	MaterialMgr.resetAll(self._itemPrize)
	self:_onClearStageCol()
	self:_onClearBuffCol()
end

function DivineFuYaoClgExtremeView:_onUpdate()
	self._isCanReset = false

	local stageDatas = DivineFuYaoClgConfig.instance:getExtremeStageDatas(self._activityId) or {}

	for _, data in ipairs(stageDatas) do
		if self._subMo:isPassStageInExt(data.stageId) then
			self._isCanReset = true
		end
	end

	GameUtil.SetGray(self._btnReset, not self._isCanReset)
	self:_onUpdateStageColUI()
	self:_onUpdateBuffColUI()

	local lockRaceIdList = self._subMo:getLockRaceIdList()
	local buffData = DivineFuYaoClgConfig.instance:getExtBuffData(self._activityId, #lockRaceIdList)

	if buffData then
		self._txtTips.text = buffData.desc or "我方精灵阵亡累计达X只，敌方全属性加成"
	end
end

function DivineFuYaoClgExtremeView:_onUpdateStageColUI()
	local datas = DivineFuYaoClgConfig.instance:getExtremeStageDatas(self._activityId) or {}

	if self._curStageId <= 0 or self._subMo:isPassStageInExt(self._curStageId) then
		self._curStageId = 1

		for idx, data in ipairs(datas) do
			self._curStageId = data.stageId

			if not self._subMo:isPassStageInExt(data.stageId) then
				break
			end
		end
	end

	GameUtil.SetActive(self._tagHasGain, self._subMo:isHasGainExtremePrize())
	self._stageScrollerList:reloadData(datas)
	self._stageScrollerList:MoveCellToCenter(self._curStageId - 1)
end

function DivineFuYaoClgExtremeView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function DivineFuYaoClgExtremeView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isPass = self._subMo:isPassStageInExt(stageId)
	local lockRaceIds = self._subMo:getLockRaceIds(stageId)
	local mainGo = cell.gameObject
	local btnClg = goutil.findChild(mainGo, "btnClg")
	local tagSelect = goutil.findChild(mainGo, "btnClg/tagSelect")
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local lockPet = goutil.findChild(mainGo, "lockPet")
	local lockPetView = goutil.findChild(mainGo, "lockPet/view")

	for idx = 1, lockPetView.transform.childCount do
		local mainGo = lockPetView.transform:GetChild(idx - 1).gameObject
		local icon = goutil.findChild(mainGo, "icon")

		if idx <= #lockRaceIds then
			local raceId = lockRaceIds[idx]

			MaterialMgr.setIcon(icon, MatType.Pet, raceId, nil, nil)
			GameUtil.SetActive(mainGo, true)
		else
			MaterialMgr.clearIcon(icon)
			GameUtil.SetActive(mainGo, false)
		end
	end

	GameUtil.SetActive(lockPet, isPass)

	txtName.text = string.format("第%s关", stageId)

	GameUtil.SetActive(tagPass, isPass)
	GameUtil.SetActive(tagSelect, self._curStageId == stageId)
	GameUtil.addClickHandler(btnClg, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		self._curStageId = stageId

		DivineFuYaoClgController.instance:enterBattleExtreme(self._activityId, stageId)
	end)
end

function DivineFuYaoClgExtremeView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnClg = goutil.findChild(mainGo, "btnClg")
	local lockPetView = goutil.findChild(mainGo, "lockPet/view")

	GameUtil.rmClickHandler(btnClg)

	for idx = 1, lockPetView.transform.childCount do
		local mainGo = lockPetView.transform:GetChild(idx - 1).gameObject
		local icon = goutil.findChild(mainGo, "icon")

		MaterialMgr.clearIcon(icon)
	end
end

function DivineFuYaoClgExtremeView:_getTagByIdx(data, idx)
	return 2 - (idx + 1) % 2
end

function DivineFuYaoClgExtremeView:_getCellSize(view, idx)
	local list = self._stageScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function DivineFuYaoClgExtremeView:_onUpdateBuffColUI()
	local cfg = DivineFuYaoClgConfig.instance:getExtElementalData(self._activityId) or {}

	self._buffScrollerList:reloadData(cfg)
end

function DivineFuYaoClgExtremeView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function DivineFuYaoClgExtremeView:_updateBuffCell(view, cell, data, tag)
	local index = cell.data
	local mainGo = cell.gameObject
	local leftIconAtlas = goutil.findChild(mainGo, "leftIconAtlas")
	local rightIconAtlas = goutil.findChild(mainGo, "rightIconAtlas")
	local txtYinji = goutil.findChildTextComponent(mainGo, "txtYinji")
	local txtbattle = goutil.findChildTextComponent(mainGo, "txtbattle")

	GameUtil.setUIGroupIdx(mainGo, (index + 1) % 2)

	for idx, go in ipairs({
		leftIconAtlas,
		rightIconAtlas
	}) do
		local iconStateKey = data.atlas[idx]
		local state = (GameEnum.Races[iconStateKey] or 1) - 1

		GameUtil.setUIImageSpriteIdx(go, state)
	end

	txtYinji.text = data.yinjiDesc
	txtbattle.text = data.battleDesc
end

function DivineFuYaoClgExtremeView:_clearBuffCell(cell)
	return
end

function DivineFuYaoClgExtremeView:_onClickBtnTip()
	local key = self._actData.prizeKeyJixian

	TipsFacade.instance:openRulesView(key)
end

function DivineFuYaoClgExtremeView:_onClickBtnReset()
	if not self._isCanReset then
		FloatWordMgr.instance:show("无可重置的关卡")

		return
	end

	local tipsContent = "是否确认重置当前所有关卡？"

	local function okFunc()
		self._curStageId = 0

		DivineFuYaoClgController.instance:sendPM_DivineFuYaoClgExtremeResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function DivineFuYaoClgExtremeView:_onClickBtnShowBuff()
	local isActive = GameUtil.GetActive(self._buffTips)

	GameUtil.SetActive(self._buffTips, not isActive)
end

return DivineFuYaoClgExtremeView
