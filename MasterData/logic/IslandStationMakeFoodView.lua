-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationMakeFoodView.lua

module("logic.extensions.islandstation.view.IslandStationMakeFoodView", package.seeall)

local IslandStationMakeFoodView = class("IslandStationMakeFoodView", ViewComponent)

function IslandStationMakeFoodView:ctor()
	IslandStationMakeFoodView.super.ctor(self)
end

function IslandStationMakeFoodView:unbindEvents()
	IslandStationMakeFoodView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnMake)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnA10)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMs)
	self._inputComp:RemoveOnValueChanged()
end

function IslandStationMakeFoodView:bindEvents()
	IslandStationMakeFoodView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnMake, self._onClickBtnMake, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnM10, self._onClickBtnLessTen, self)
	GameUtil.addClickHandler(self._btnA10, self._onClickBtnAddTen, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickBtnAdd, self)
	GameUtil.addClickHandler(self._btnMs, self._onClickBtnLess, self)
	self._inputComp:AddOnValueChanged(self._onValueChanged, self)
end

function IslandStationMakeFoodView:buildUI()
	IslandStationMakeFoodView.super.buildUI(self)

	self._inputComp = self:getInput("inputNum")
	self._txtInput = self:getTxt("inputNum/Text")
	self._btnMake = self:getGo("btnMake")
	self._tip = self:getGo("txtTip")
	self._btnClose = self:getGo("btnClose")
	self._btnA10 = self:getGo("adjust/BtnA10")
	self._btnMs = self:getGo("adjust/BtnMs")
	self._btnAdd = self:getGo("adjust/BtnAdd")
	self._btnM10 = self:getGo("adjust/BtnM10")
	self._foodTableView = self:getGo("foodTableView")
	self._foodTablecell = self:getGo("foodTableView/tablecell")
	self._foodScrollList = ScrollerList.create(self._foodTableView, self._foodTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecell = self:getGo("materialTableView/tablecell")
	self._materialTableView = self:getGo("materialTableView")
	self._cookBookScrollList = ScrollerList.create(self._materialTableView, self._tablecell, GameUtil.handler(self._updateCookBookCell, self), GameUtil.handler(self._clearCookBookCell, self))
end

function IslandStationMakeFoodView:onExit()
	IslandStationMakeFoodView.super.onExit(self)
	self._cookBookScrollList:dispose()
	self._foodScrollList:dispose()
end

function IslandStationMakeFoodView:onEnter()
	IslandStationMakeFoodView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.IslandStationFightBossBegin, self.close, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationMakeFoodRes, self._onMakeFoodRes, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationEndGameRes, self._onEndGameRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._shopId = checknumber(params[2])
	self._grilFoodCfg = IslandStationConfig.instance:getGirlFoodCfg(self._activityId)

	local localFoodList, curGrilFoodsList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._shopId)

	self._cookFoodNum = 1
	self._curFoodNum = #curGrilFoodsList

	local curGirlFoodCfg = curGrilFoodsList[1]

	self._chooseFoodId = curGirlFoodCfg ~= nil and curGirlFoodCfg.foodId or 0

	if self._curFoodNum > 0 then
		self._stuffDic = IslandStationConfig.instance:getFoodCookDic(self._activityId, self._chooseFoodId)

		self._foodScrollList:reloadData(curGrilFoodsList)
		self:_updateCookBookList()
		self._inputComp:SetText(self._cookFoodNum)
	else
		self._cookFoodNum = 1

		self._inputComp:SetText(self._cookFoodNum)
	end

	self:_updateBtnMakeState()
	GameUtil.SetActive(self._tip, self._curFoodNum <= 0)
	GameUtil.SetActive(self._foodTableView, self._curFoodNum > 0)
	GameUtil.SetActive(self._materialTableView, self._curFoodNum > 0)
end

function IslandStationMakeFoodView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local btnChoose = goutil.findChild(cell, "btnChoose")
	local txtPrize = goutil.findChildTextComponent(cell, "txtPrize")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.materialStr)

	txtName.text = data.name

	GameUtil.SetActive(imgChoose, data.foodId == self._chooseFoodId)
	MaterialMgr.setCellByCfg(data.materialStr, con)
	GameUtil.addClickHandler(btnChoose, GameUtil.handler(self._onClickBtnChoose, self, data.foodId), self)

	txtPrize.text = string.format("%d奥币/份", data.price)
end

function IslandStationMakeFoodView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")
	local btnChoose = goutil.findChild(cell, "btnChoose")

	GameUtil.rmClickHandler(btnChoose)
	MaterialMgr.resetAll(con)
end

function IslandStationMakeFoodView:_updateCookBookCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local btnGet = goutil.findChild(cell, "btnGet")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtLeftNum = goutil.findChildTextComponent(cell, "txtLeftNum")
	local foodStuffCfg = IslandStationConfig.instance:getFoodStuffCfgById(self._activityId, data.foodStuff)
	local hasStuffNum = IslandStationModel.instance:getStuffNum(self._activityId, data.foodStuff)
	local oneFoodNeedStuffNum = self._stuffDic[data.foodStuff]
	local leftNum = hasStuffNum - oneFoodNeedStuffNum * self._cookFoodNum
	local showLeftNum = math.max(leftNum, 0)
	local matType, matId, matNum = MaterialMgr.getMatParams(foodStuffCfg.materialStr)
	local finalMatStr = string.format("%s:%s", matType, matId)

	txtNum.text = data.txtNum
	txtLeftNum.text = string.format("余：%d", showLeftNum)

	MaterialMgr.setCellByCfg(finalMatStr, con)
	GameUtil.SetActive(btnGet, leftNum < 0)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnGet, self, data.foodStuff), self)
end

function IslandStationMakeFoodView:_clearCookBookCell(cell)
	local con = goutil.findChild(cell, "con")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnGet)
end

function IslandStationMakeFoodView:_onClickBtnChoose(foodId)
	self._cookFoodNum = 1
	self._chooseFoodId = foodId
	self._stuffDic = IslandStationConfig.instance:getFoodCookDic(self._activityId, self._chooseFoodId)

	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, foodId)
	local localFoodList, curGrilFoodsList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._shopId)

	self._inputComp:SetText(self._cookFoodNum)
	self._foodScrollList:reloadData(curGrilFoodsList)
	self:_updateCookBookList()
	self:_updateBtnMakeState()
end

function IslandStationMakeFoodView:_updateCookBookList()
	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)
	local cookBookList = {}

	for i, cfg in pairs(cookBookCfg) do
		table.insert(cookBookList, cfg)
	end

	self._cookBookScrollList:reloadData(cookBookList)
end

function IslandStationMakeFoodView:_onClickBtnGet(foodStuff)
	UIStateManager.instance:push(ViewName.IslandStationGetMaterialView, self._activityId)
end

function IslandStationMakeFoodView:_onClickBtnLessTen()
	if self._curFoodNum <= 0 then
		FloatWordMgr.instance:show("暂未解锁女神食谱,去提升女神好感度解锁更多食谱吧!")

		return
	end

	if self._cookFoodNum == 1 then
		FloatWordMgr.instance:show("制作数量无法再减少")

		return
	end

	self._cookFoodNum = self._cookFoodNum <= 10 and 1 or self._cookFoodNum - 10

	self._inputComp:SetText(self._cookFoodNum)

	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)
	local cookBookList = {}

	for i, cfg in pairs(cookBookCfg) do
		table.insert(cookBookList, cfg)
	end

	self._cookBookScrollList:reloadData(cookBookList)
end

function IslandStationMakeFoodView:_onClickBtnAddTen()
	if self._curFoodNum <= 0 then
		FloatWordMgr.instance:show("暂未解锁女神食谱,去提升女神好感度解锁更多食谱吧!")

		return
	end

	local materialEnough = self:_materialIsEnough(self._cookFoodNum + 10)

	if materialEnough then
		self._cookFoodNum = self._cookFoodNum + 10
	else
		local maxCookNum = self:_getMaxCookNum()

		if self._cookFoodNum == maxCookNum then
			FloatWordMgr.instance:show("已达到当前食材可制作上限")
		end

		self._cookFoodNum = maxCookNum
	end

	self._inputComp:SetText(self._cookFoodNum)

	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)
	local cookBookList = {}

	for i, cfg in pairs(cookBookCfg) do
		table.insert(cookBookList, cfg)
	end

	self._cookBookScrollList:reloadData(cookBookList)
end

function IslandStationMakeFoodView:_onClickBtnAdd()
	if self._curFoodNum <= 0 then
		FloatWordMgr.instance:show("暂未解锁女神食谱,去提升女神好感度解锁更多食谱吧!")

		return
	end

	local nextFoodNum = self._cookFoodNum + 1

	if not self:_materialIsEnough(nextFoodNum) then
		FloatWordMgr.instance:show("已达到当前食材可制作上限")

		return
	end

	self._cookFoodNum = nextFoodNum

	self._inputComp:SetText(self._cookFoodNum)

	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)
	local cookBookList = {}

	for i, cfg in pairs(cookBookCfg) do
		table.insert(cookBookList, cfg)
	end

	self._cookBookScrollList:reloadData(cookBookList)
end

function IslandStationMakeFoodView:_onClickBtnLess()
	if self._curFoodNum <= 0 then
		FloatWordMgr.instance:show("暂未解锁女神食谱,去提升女神好感度解锁更多食谱吧!")

		return
	end

	if self._cookFoodNum == 1 then
		FloatWordMgr.instance:show("制作数量无法再减少")

		return
	end

	if self._cookFoodNum > 1 then
		self._cookFoodNum = self._cookFoodNum - 1
	end

	self._inputComp:SetText(self._cookFoodNum)

	local cookBookList = {}
	local cookBookCfg = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)

	for i, cfg in pairs(cookBookCfg) do
		table.insert(cookBookList, cfg)
	end

	self._cookBookScrollList:reloadData(cookBookList)
end

function IslandStationMakeFoodView:_onValueChanged(numStr)
	if self._curFoodNum > 0 then
		local cookNum = checkint(numStr)

		self._inputComp:SetText(tostring(cookNum))
		self:_updateCookBookList()
	end
end

function IslandStationMakeFoodView:_onClickBtnMake()
	if self._curFoodNum <= 0 then
		FloatWordMgr.instance:show("暂未解锁女神食谱,去提升女神好感度解锁更多食谱吧!")

		return
	end

	if self._cookFoodNum <= 0 then
		FloatWordMgr.instance:show("无法制作数量为0个的食物")

		return
	end

	local materialEnough = self:_materialIsEnough(self._cookFoodNum)

	if not materialEnough then
		FloatWordMgr.instance:show("材料不足！")

		return
	end

	IslandStationController.instance:sendPM_IslandStationMakeFoodReq(self._activityId, self._chooseFoodId, self._cookFoodNum)
end

function IslandStationMakeFoodView:_materialIsEnough(cookNum)
	local curMaterialCfgs = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)

	for i, cfg in pairs(curMaterialCfgs) do
		local hasStuffNum = IslandStationModel.instance:getStuffNum(self._activityId, cfg.foodStuff)
		local needMaterialNum = cfg.stuffCount * cookNum

		if hasStuffNum < needMaterialNum then
			return false
		end
	end

	return true
end

function IslandStationMakeFoodView:_getMaxCookNum()
	local curMaterialCfgs = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)
	local maxNum = 999

	for i, cfg in pairs(curMaterialCfgs) do
		local hasStuffNum = IslandStationModel.instance:getStuffNum(self._activityId, cfg.foodStuff)
		local needMaterialNum = cfg.stuffCount
		local canMakeNum = math.floor(hasStuffNum / needMaterialNum)

		if canMakeNum <= maxNum then
			maxNum = canMakeNum
		end
	end

	if maxNum == 0 then
		maxNum = 1
	end

	return maxNum
end

function IslandStationMakeFoodView:_onMakeFoodRes()
	local curGirlFoodCfg = IslandStationConfig.instance:getFoodCfgByFoodId(self._activityId, self._chooseFoodId)
	local list = {}
	local type, id, num = MaterialMgr.getMatParams(curGirlFoodCfg.materialStr)

	if type == MatType.Item_Fake then
		local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, self._cookFoodNum)

		table.insert(list, mo)
	end

	local obj = {}

	obj.items = list
	obj.ci = 0

	MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
	MaterialController.instance:checkAndOpenDisplay()

	local localFoodList, curGrilFoodsList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._shopId)
	local curGirlFoodCfg = curGrilFoodsList[1]

	self._chooseFoodId = curGirlFoodCfg.foodId
	self._stuffDic = IslandStationConfig.instance:getFoodCookDic(self._activityId, self._chooseFoodId)
	self._cookFoodNum = 1
	self._curFoodNum = #curGrilFoodsList

	self._foodScrollList:reloadData(curGrilFoodsList)
	self:_updateCookBookList()
	self:_updateBtnMakeState()
	self._inputComp:SetText(self._cookFoodNum)
	GameUtil.SetActive(self._tip, self._curFoodNum <= 0)
end

function IslandStationMakeFoodView:_onEndGameRes()
	local localFoodList, curGrilFoodsList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._shopId)
	local curGirlFoodCfg = curGrilFoodsList[1]

	self._chooseFoodId = curGirlFoodCfg.foodId
	self._stuffDic = IslandStationConfig.instance:getFoodCookDic(self._activityId, self._chooseFoodId)
	self._cookFoodNum = 1
	self._curFoodNum = #curGrilFoodsList

	self._foodScrollList:reloadData(curGrilFoodsList)
	self:_updateCookBookList()
	self:_updateBtnMakeState()
	self._inputComp:SetText(self._cookFoodNum)
	GameUtil.SetActive(self._tip, self._curFoodNum <= 0)
end

function IslandStationMakeFoodView:_updateBtnMakeState()
	local gray = false
	local curMaterialCfgs = IslandStationConfig.instance:getCookBookCfgByFoodId(self._activityId, self._chooseFoodId)

	if curMaterialCfgs then
		for i, cfg in pairs(curMaterialCfgs) do
			local hasStuffNum = IslandStationModel.instance:getStuffNum(self._activityId, cfg.foodStuff)

			if hasStuffNum <= 0 then
				gray = true

				break
			end
		end
	end

	GameUtil.SetGray(self._btnMake.gameObject, gray)
end

return IslandStationMakeFoodView
