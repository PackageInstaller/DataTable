-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewarmultidselectView.lua

module("logic.extensions.itembag.view.RewarmultidselectView", package.seeall)

local RewarmultidselectView = class("RewarmultidselectView", ViewComponent)
local TOTAL_MAX_LIMIT = 99999

function RewarmultidselectView:buildUI()
	RewarmultidselectView.super.buildUI(self)

	self.txtTitle = self:getTxt("txtTitle")
	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.txtRemain = self:getTxt("txtRemain")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
	self.SearchInputField = self:getInput("SearchInputField")
	self._empty = self:getGo("empty")
end

function RewarmultidselectView:bindEvents()
	RewarmultidselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
	self.SearchInputField:AddOnValueChanged(self._onSearchValueChanged, self)
end

function RewarmultidselectView:unbindEvents()
	RewarmultidselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
	self.SearchInputField:RemoveOnValueChanged()
end

function RewarmultidselectView:destroyUI()
	RewarmultidselectView.super.destroyUI(self)
end

function RewarmultidselectView:onEnter()
	RewarmultidselectView.super.onEnter(self)

	self._itemData = self._viewPresentor._openParam[1]

	self.scrollList:regReloadFinish(GameUtil.handler(self.reloadEnd, self))

	self._itemCountMap = {}

	self:refreshUI()

	local cfg = self._viewPresentor._openParam[2]

	self.txtTitle.text = lang("奖励选择")

	if cfg and not string.nilorempty(cfg.title) then
		self.txtTitle.text = cfg.title
	end
end

function RewarmultidselectView:onEnterFinished()
	RewarmultidselectView.super.onEnterFinished(self)
end

function RewarmultidselectView:onExit()
	RewarmultidselectView.super.onExit(self)
	self.scrollList:dispose()
end

function RewarmultidselectView:onExitFinished()
	RewarmultidselectView.super.onExitFinished(self)
end

function RewarmultidselectView:refreshUI()
	local cfg = MaterialConfig.instance:getCfgByMatAndId(self._itemData.type, self._itemData.id)
	local content = cfg.content
	local arr = string.split(content, ";")
	local searchStr = self.SearchInputField:GetText()

	if not string.nilorempty(searchStr) then
		local result = {}

		for i, v in ipairs(arr) do
			if not string.nilorempty(v) then
				local matType, matId, matNum = MaterialMgr.getMatParams(v)
				local matName = MaterialMgr.getMaterialsName(matType, matId)
				local cfg = MaterialMgr.getMatCfg(matType, matId)

				if string.find(matName, searchStr) or not string.nilorempty(cfg.searchKey) and string.find(cfg.searchKey, searchStr) then
					table.insert(result, v)
				end
			end
		end

		arr = result
	end

	self.scrollList:reloadData(arr)

	local len = #arr

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, -15)
	GameUtil.SetActive(self._empty, len <= 0)

	self.txtRemain.text = langPara("已选择物品：<color=#20b376>%s</color>/%s", 0, self._itemData.num)
end

function RewarmultidselectView:reloadEnd()
	return
end

function RewarmultidselectView:_onSearchValueChanged(searchStr)
	self:refreshUI()
end

function RewarmultidselectView:_getCurTotalNum()
	local num = 0

	for k, v in pairs(self._itemCountMap) do
		num = num + v
	end

	return num
end

function RewarmultidselectView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function RewarmultidselectView:updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local item = goutil.findChild(cell, "item")
	local btnAdd = goutil.findChild(cell, "chooseCount/btnAdd")
	local btnLess = goutil.findChild(cell, "chooseCount/btnLess")
	local inputField = Framework.InputFieldAdapter.GetFrom(cell.gameObject, "chooseCount/InputField")
	local markArtifact = goutil.findChild(cell, "markArtifact")
	local withTag = goutil.findChild(cell, "withTag")
	local notWithTag = goutil.findChild(cell, "notWithTag")
	local awake = goutil.findChild(cell, "awake")
	local imgAwake = goutil.findChildComponent(cell, "awake/imgLv", "UIImageSpriteChange")

	GameUtil.SetActive(awake, false)

	local matType, cfgId, num = MaterialMgr.getMatParams(data)
	local isWith = MaterialMgr.isWithInSkinPrize(matType, cfgId)

	if matType == MatType.PET_SKIN then
		GameUtil.SetActive(withTag, isWith)
		GameUtil.SetActive(notWithTag, false)
	else
		GameUtil.SetActive(withTag, isWith)
		GameUtil.SetActive(notWithTag, false)
	end

	if matType == MatType.Pet then
		local awakenLv = BagModel.instance:getMaxAwakenLv(cfgId)

		if BagModel.instance:isExistRaceId(cfgId) then
			GameUtil.SetActive(awake, true)
			imgAwake:SetState(awakenLv)
		end
	end

	local proxy = MaterialMgr.setCellByCfg(data, item)

	if proxy then
		if matType == MatType.Item and CutePetConfig.instance:isIllusionCard(cfgId) == true then
			local raceId = checknumber(CutePetConfig.instance:getIllusionCardCutePet(cfgId))
			local raceInfo = CutePetModel.instance:getCuteSuitInfo(raceId)

			if raceInfo then
				if not raceInfo.unLocked then
					local hasTag = false
					local withState = hasTag and 1 or 0

					proxy.binder:setWithTag(withState)
				end
			end
		elseif matType == MatType.Item or MaterialMgr.SkinPrizeCheckTypes[matType] then
			proxy.binder:setWithTag(0)
		end
	end

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)
	txtCount.text = "x" .. num

	local mountId = MountConfig.instance:getMountInMap(matType, cfgId)

	if matType == MatType.StarGodPlus then
		local haveNum = StargodplusModel.instance:getMaterialNumWithCfg(data)

		txtHaveCount.text = langPara("item_have", haveNum)
	else
		txtHaveCount.text = mountId ~= nil and MountModel.instance:getLockmountsById(mountId) ~= false and langPara("item_have", MaterialMgr.getMatCount(data) + 1) or langPara("item_have", MaterialMgr.getMatCount(data))
	end

	goutil.setActive(markArtifact, false)

	if matType == MatType.Equipment then
		local matCfg = MaterialMgr.getMatCfg(matType, cfgId)

		if matCfg.throneRelatedSkinId > 0 and matCfg.afterComposeGroup > 0 then
			local equipInfoList = PetEquipModel.instance:GetEquipInfos(matCfg.afterComposeGroup) or {}

			goutil.setActive(markArtifact, #equipInfoList > 0)
		end
	end

	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickItemAdd, self, data))
	GameUtil.addClickHandler(btnLess, GameUtil.handler(self._onClickItemCut, self, data))
	inputField:RemoveOnValueChanged()
	inputField:SetText(tostring(checknumber(self._itemCountMap[data])))
	inputField:AddOnValueChanged(function(strNum)
		inputField:RemoveOnValueChanged()

		local num = checknumber(inputField:GetText())
		local lastNum = checknumber(self._itemCountMap[data])
		local curNum = self:_getCurTotalNum()
		local maxNum = math.min(TOTAL_MAX_LIMIT, self._itemData.num)
		local left = maxNum - curNum + lastNum

		left = self:_checkAndChangeLeft(data, left)
		num = Mathf.Clamp(num, 0, left)
		self._itemCountMap[data] = num

		inputField:SetText(tostring(num))
		self.scrollList:refresh()

		local curNum = self:_getCurTotalNum()

		self.txtRemain.text = langPara("已选择物品：<color=#20b376>%s</color>/%s", curNum, self._itemData.num)
	end, self)
end

function RewarmultidselectView:_checkAndChangeLeft(data, left)
	local matType, cfgId, num = MaterialMgr.getMatParams(data)

	if (matType == MatType.Bubble or matType == MatType.OpeningEffect or matType == MatType.HomePageBg or matType == MatType.NameFrame or matType == MatType.PlayerMessageSkin or matType == MatType.BattleUserInterfaceSkin or matType == MatType.BattleBackgroundSkin) and MaterialMgr.getMatCount(data) > 0 then
		left = 0
	end

	return left
end

function RewarmultidselectView:_onClickItemCut(data)
	local num = checknumber(self._itemCountMap[data])
	local curNum = self:_getCurTotalNum()
	local maxNum = math.min(TOTAL_MAX_LIMIT, self._itemData.num)

	if num - 1 >= 0 then
		num = num - 1
		self._itemCountMap[data] = num

		self.scrollList:refresh()

		local curNum = self:_getCurTotalNum()

		self.txtRemain.text = langPara("已选择物品：<color=#20b376>%s</color>/%s", curNum, self._itemData.num)
	end
end

function RewarmultidselectView:_onClickItemAdd(data)
	local num = checknumber(self._itemCountMap[data])
	local curNum = self:_getCurTotalNum()
	local maxNum = math.min(TOTAL_MAX_LIMIT, self._itemData.num)
	local left = maxNum - curNum + num

	left = self:_checkAndChangeLeft(data, left)

	if left >= num + 1 then
		num = num + 1
		self._itemCountMap[data] = num

		self.scrollList:refresh()

		local curNum = self:_getCurTotalNum()

		self.txtRemain.text = langPara("已选择物品：<color=#20b376>%s</color>/%s", curNum, self._itemData.num)
	else
		TipsFacade.instance:openCommonTips("选择数量或者拥有数量已达到上限")
	end
end

function RewarmultidselectView:_onClickSure()
	local curCount = self:_getCurTotalNum()

	if curCount > 0 then
		local list = {}
		local obj = {}

		obj.itemMap = {}

		for k, v in pairs(self._itemCountMap) do
			if v > 0 then
				local boo = ItemBagController.instance:checkItemChangeWhenGet(k, GameUtil.handler(self.sendOneMsg, self, k, v))

				if boo then
					return
				end

				if v > 0 then
					local matType, cfgId, matNum = MaterialMgr.getMatParams(k)
					local name2 = MaterialMgr.getMaterialsName(matType, cfgId)
					local str = name2 .. "x" .. v * matNum

					table.insert(list, str)

					obj.itemMap[k] = v
				end
			end
		end

		local name1 = MaterialMgr.getMaterialsName(self._itemData.type, self._itemData.id)
		local num1 = curCount

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("消耗%s个%s兑换成%s?", num1, name1, table.concat(list, ",")), GameUtil.handler(self.sendMsg, self, curCount, obj))
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一项物品"))
	end
end

function RewarmultidselectView:sendOneMsg(v, count)
	if not string.nilorempty(v) then
		local obj = {}

		obj.itemMap = {}
		obj.itemMap[v] = count

		local num = count

		MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, GameUtil.jsonToString(obj), GameUtil.handler(self.close, self))
	end
end

function RewarmultidselectView:sendMsg(num, obj)
	if obj then
		MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, GameUtil.jsonToString(obj), GameUtil.handler(self.close, self))
	end
end

return RewarmultidselectView
