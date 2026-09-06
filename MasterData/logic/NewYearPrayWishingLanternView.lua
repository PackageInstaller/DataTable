-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayWishingLanternView.lua

module("logic.extensions.newyearpray.view.NewYearPrayWishingLanternView", package.seeall)

local NewYearPrayWishingLanternView = class("NewYearPrayWishingLanternView", ViewComponent)

function NewYearPrayWishingLanternView:ctor()
	NewYearPrayWishingLanternView.super.ctor(self)
end

function NewYearPrayWishingLanternView:buildUI()
	NewYearPrayWishingLanternView.super.buildUI(self)

	self._tabTitile = goutil.findChild(self.mainGO, "tabTitile")
	self._tabTitile_txt = goutil.findChildTextComponent(self.mainGO, "tabTitile/txt")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function NewYearPrayWishingLanternView:bindEvents()
	NewYearPrayWishingLanternView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function NewYearPrayWishingLanternView:unbindEvents()
	NewYearPrayWishingLanternView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSure)
end

function NewYearPrayWishingLanternView:onEnter()
	NewYearPrayWishingLanternView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stepId = checknumber(params[2])

	if self._activityId <= 0 or self._stepId <= 0 then
		self:close()

		return
	end

	self._activityType = NewYearPrayController.instance:getActivityType()
	self._playerMo = NewYearPrayController.instance:getNypPlayerMo(self._activityId)
	self._curTabId = self._playerMo:getTodayWishingTabId()
	self._curPartIdx = 0

	self:_onSetUI()
	self:_onUpdate()
end

function NewYearPrayWishingLanternView:onExit()
	NewYearPrayWishingLanternView.super.onExit(self)
	self:_onClear()
end

function NewYearPrayWishingLanternView:_onSetUI()
	return
end

function NewYearPrayWishingLanternView:_onUpdate()
	self:_onUpdateTabColUI()
	self:_onUpdatePartColUI()
	GameUtil.SetGray(self._btnSure, not (self._curTabId > 0) or not (self._curPartIdx > 0))
end

function NewYearPrayWishingLanternView:_onClear()
	self:_onClearPartCol()
end

function NewYearPrayWishingLanternView:_onUpdateTabColUI()
	local tabData = NewYearPrayConfig.instance:getNypWishingTabDataByAct(self._activityId, self._curTabId)

	self._tabTitile_txt.text = tabData.name
end

function NewYearPrayWishingLanternView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local childGo = self._partCell
	local cfg = {}
	local tabData = NewYearPrayConfig.instance:getNypWishingTabDataByAct(self._activityId, self._curTabId)

	if tabData then
		for _, lanternId in ipairs(tabData.lanternIdList) do
			local data = NewYearPrayConfig.instance:getNypWishingLanternData(lanternId)

			if data then
				table.insert(cfg, data)
			end
		end
	end

	self._partDataList = cfg

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = children[idx]

					if mainGo == nil then
						mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
					end

					self:_updatePartCell(mainGo, idx, data)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearPartCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function NewYearPrayWishingLanternView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function NewYearPrayWishingLanternView:_updatePartCell(mainGo, partIdx, data)
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local icon = goutil.findChild(mainGo, "icon")
	local isSelected = self._curPartIdx == partIdx

	GameUtil.SetActive(imgSelected, isSelected)
	self:_loadBigBg(icon, data.iconPath, true)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPartCell, self, partIdx, data))
end

function NewYearPrayWishingLanternView:_clearPartCell(mainGo)
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(mainGo)
	self:_unLoadBigBg(icon)
end

function NewYearPrayWishingLanternView:_onClickPartCell(partIdx, data)
	self._curPartIdx = partIdx

	self:_onUpdate()
	GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfSpineAnim, data.animName)
	GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfBubble, data.bubbleId)
end

function NewYearPrayWishingLanternView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function NewYearPrayWishingLanternView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function NewYearPrayWishingLanternView:_onClickBtnTip()
	local key = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function NewYearPrayWishingLanternView:_onClickBtnSure()
	if self._curTabId <= 0 then
		return
	end

	if self._curPartIdx <= 0 then
		return
	end

	if self._partDataList then
		local data = self._partDataList[self._curPartIdx]

		if data == nil then
			return
		end

		self._playerMo:setChoiceLanternId(data.lanternId)
		self._playerMo:setChoiceId(self._stepId, data.choiceId)
		GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfNextScene)
	end
end

return NewYearPrayWishingLanternView
