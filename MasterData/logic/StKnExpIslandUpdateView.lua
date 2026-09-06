-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpIslandUpdateView.lua

module("logic.extensions.stknexp.view.StKnExpIslandUpdateView", package.seeall)

local StKnExpIslandUpdateView = class("StKnExpIslandUpdateView", ViewComponent)

function StKnExpIslandUpdateView:buildUI()
	StKnExpIslandUpdateView.super.buildUI(self)

	local islandScrView = self:getGo("islandCol/scrView")
	local islandScrCell = self:getGo("islandCol/scrCell")

	self._islandScrollerList = ScrollerList.create(islandScrView, islandScrCell, GameUtil.handler(self._updateIslandCell, self), GameUtil.handler(self._clearIslandCell, self))

	self._islandScrollerList:setCenterMode(true)

	local levelScrView = self:getGo("levelCol/scrView")
	local levelScrCell = self:getGo("levelCol/scrCell")

	self._levelScrollerList = ScrollerList.create(levelScrView, levelScrCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._btnClose = self:getGo("btnClose")
	self._prizeScrollListDic = {}
end

function StKnExpIslandUpdateView:bindEvents()
	StKnExpIslandUpdateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function StKnExpIslandUpdateView:unbindEvents()
	StKnExpIslandUpdateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StKnExpIslandUpdateView:onEnter()
	StKnExpIslandUpdateView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local islandId = checknumber(params[2])
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._curIsland = islandId > 0 and islandId or self._curIsland or 1

	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionUpgardeIslandRes, self._onUpdate, self)
	self:_onUpdate()
end

function StKnExpIslandUpdateView:onExit()
	StKnExpIslandUpdateView.super.onExit(self)
	self:_onClear()
end

function StKnExpIslandUpdateView:_onUpdate()
	local islandCfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	self._islandScrollerList:reloadData(islandCfg)

	local levelCfg = StKnExpConfig.instance:getIslandLevelCfg(self._activityId, self._curIsland) or {}

	self._levelScrollerList:reloadData(levelCfg)

	local index = self._subMo:getIslandLevel(self._curIsland)

	self._levelScrollerList:MoveCellToCenter(Mathf.Max(index - 1, 0))
end

function StKnExpIslandUpdateView:_onClear()
	self._islandScrollerList:dispose()
	self._levelScrollerList:dispose()
end

function StKnExpIslandUpdateView:_updateIslandCell(view, cell, data, tag)
	local islandId = data.islandId
	local skinId = data.skinId
	local isSelected = self._curIsland == islandId
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local selectTag = goutil.findChild(mainGo, "selectTag")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
	GameUtil.SetActive(selectTag, isSelected)

	txtName.text = CharacterConfig.instance:getPetName(skinId)

	GameUtil.addClickHandler(mainGo, function()
		if self._curIsland ~= islandId then
			self._curIsland = islandId

			self:_onUpdate()
		end
	end)
end

function StKnExpIslandUpdateView:_clearIslandCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function StKnExpIslandUpdateView:_updateLevelCell(view, cell, data, tag)
	local islandId = data.islandId
	local level = data.level
	local curLevel = self._subMo:getIslandLevel(islandId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local tagGain = goutil.findChild(mainGo, "tagGain")
	local txtTagLock = goutil.findChildTextComponent(mainGo, "txtTagLock")
	local prizeCol = goutil.findChild(mainGo, "prizeCol")
	local prizeScrView = goutil.findChild(mainGo, "prizeCol/scrView")
	local prizeScrCell = goutil.findChild(mainGo, "prizeCol/scrCell")

	txtLevel.text = string.format("Lv.%s", level)

	GameUtil.SetActive(txtTagLock.gameObject, curLevel < level)
	GameUtil.SetActive(tagGain, level <= curLevel and data.exp > 0)

	txtTagLock.text = data.exp > 0 and string.format("建设进度%s解锁", data.exp) or ""
	txtDesc.text = data.desc

	if not string.nilorempty(data.prize) then
		GameUtil.SetActive(prizeCol, true)

		local prizeStrArr = string.split(data.prize, "#")

		if not self._prizeScrollListDic[mainGo] then
			local scrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

			self._prizeScrollListDic[mainGo] = self._prizeScrollListDic[mainGo]

			self._prizeScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._prizeScrollListDic[mainGo]:dragNotifyParent()
		end
	else
		GameUtil.SetActive(prizeCol, false)

		local scrollList = self._prizeScrollListDic[mainGo]

		if scrollList then
			scrollList:dispose()
		end
	end

	local isEmptyDesc = string.nilorempty(data.desc)

	GameUtil.SetActive(txtDesc.gameObject, not isEmptyDesc)
	GameUtil.SetActive(prizeScrView, isEmptyDesc)
end

function StKnExpIslandUpdateView:_clearLevelCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local scrollList = self._prizeScrollListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._prizeScrollListDic[mainGo] = nil
	end

	MaterialMgr.clearIcon(icon)
end

function StKnExpIslandUpdateView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function StKnExpIslandUpdateView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function StKnExpIslandUpdateView:_onClickBtnClose()
	self:close()
end

return StKnExpIslandUpdateView
