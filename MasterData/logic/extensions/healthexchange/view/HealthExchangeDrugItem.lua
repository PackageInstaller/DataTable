-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthExchangeDrugItem.lua

module("logic.extensions.healthexchange.view.HealthExchangeDrugItem", package.seeall)

local M = class("HealthExchangeDrugItem")
local ButtonAdapter = Astral.ButtonAdapter
local longClickTriggerTime = 0.3

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self.mainGO

	self._selectMarkObj = goutil.findChild(mainGO, "imgOperate").gameObject
	self._selectCountGo = goutil.findChild(mainGO, "imgOperate/count").gameObject
	self._selectCountTxt = goutil.findChildTextComponent(mainGO, "imgOperate/count/txtCount")
	self._numberTxt = goutil.findChildTextComponent(mainGO, "txtDown")
	self._reduceGo = goutil.findChild(mainGO, "imgOperate/btnCut").gameObject
	self._imgIcon = goutil.findChildComponent(mainGO, "imgIcon", UIComponentType.Image)

	local signRoot = goutil.findChildComponent(mainGO, "time", UIComponentType.RectTransform)

	goutil.setActive(signRoot.gameObject, true)

	for i = 0, signRoot.childCount - 1 do
		goutil.setActive(signRoot:GetChild(i).gameObject, false)
	end

	self._goExpireTimeDay = goutil.findChild(mainGO, "time/type1").gameObject
	self._txtExpireTimeDay = goutil.findChildTextComponent(mainGO, "time/type1/txtTime")
	self._goExpireTimeHour = goutil.findChild(mainGO, "time/type2").gameObject
	self._txtExpireTimeHour = goutil.findChildTextComponent(mainGO, "time/type2/txtTime")
	self._btnSelect = OnceLongPressTrigger.Get(goutil.findChild(mainGO, "click").gameObject)

	self._btnSelect:SetTriggerTime(longClickTriggerTime)
	self._btnSelect:AddClickListener(self._clickSelect, self)
	self._btnSelect:AddLongPressListener(self._longClickSelect, self)
	self._btnSelect:AddLongPressExitListener(self._onLongClickSelectExit, self)

	self._btnReduce = OnceLongPressTrigger.Get(self._reduceGo)

	self._btnReduce:SetTriggerTime(longClickTriggerTime)
	self._btnReduce:AddClickListener(self._clickReduce, self)
	self._btnReduce:AddLongPressListener(self._longClickReduce, self)
	self._btnReduce:AddLongPressExitListener(self._onLongClickReduceExit, self)
end

function M:destroyUI()
	self._selectMarkObj = nil
	self._selectCountGo = nil
	self._selectCountTxt = nil
	self._numberTxt = nil
	self._reduceGo = nil
	self._imgIcon = nil
	self._goExpireTime = nil
	self._txtExpireTime = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	self._btnSelect:RemoveClickListener()
	self._btnReduce:RemoveClickListener()
end

function M:setCellData(drugData, index)
	self._curIndex = index
	self._itemData = drugData

	local hasData = drugData ~= nil

	goutil.setActive(self._imgIcon.gameObject, hasData)
	goutil.setActive(self._btnSelect.gameObject, hasData)
	goutil.setActive(self._numberTxt.gameObject, hasData)

	if drugData then
		self:_initView()
		self:_refreshView()
	else
		goutil.setActive(self._goExpireTimeDay, false)
		goutil.setActive(self._goExpireTimeHour, false)
		goutil.setActive(self._selectMarkObj, false)
	end
end

function M:_initView()
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._itemData.id)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemCo.icon)

	self._numberTxt.text = self._itemData.count

	local day = 0
	local expireTime = self._itemData.expireTime

	expireTime = expireTime or 0
	expireTime = tonumber(expireTime)

	if expireTime > 0 then
		local curTime = ServerTime.now() * 1000
		local offset = expireTime - curTime

		day = math.floor(offset / 1000 / 86400)

		if day > 0 then
			self._txtExpireTimeDay.text = HealthExchangeModel.instance:getExpiredTimeStr(expireTime)
		else
			self._txtExpireTimeHour.text = HealthExchangeModel.instance:getExpiredTimeStr(expireTime)
		end

		goutil.setActive(self._goExpireTimeDay, day > 0)
		goutil.setActive(self._goExpireTimeHour, day <= 0)
	else
		goutil.setActive(self._goExpireTimeDay, false)
		goutil.setActive(self._goExpireTimeHour, false)
	end
end

function M:_refreshView()
	if self._itemData.hasAddCount == 0 then
		goutil.setActive(self._reduceGo, false)
		goutil.setActive(self._selectMarkObj, false)
		goutil.setActive(self._selectCountGo, false)
	else
		goutil.setActive(self._reduceGo, true)
		goutil.setActive(self._selectMarkObj, true)
		goutil.setActive(self._selectCountGo, true)

		self._selectCountTxt.text = self._itemData.hasAddCount
	end
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex)
	end
end

function M:_clickSelect()
	if self._itemData.count == 0 then
		self:_showItemTips()

		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "clickItem", self._curIndex)
	end
end

function M:_longClickSelect(isLongPressOn)
	if self._itemData.count == 0 then
		return
	end

	if self._clickCallBackFunc then
		if isLongPressOn then
			self._clickCallBackFunc(self._clickCallBackHandler, "longClickItem", self._curIndex)
		else
			self._clickCallBackFunc(self._clickCallBackHandler, "longClickItemFinish", self._curIndex)
		end
	end
end

function M:_onLongClickSelectExit()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "longClickItemFinish", self._curIndex)
	end
end

function M:_clickReduce()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "clickReduce", self._curIndex)
	end
end

function M:_longClickReduce(isLongPressOn)
	if self._clickCallBackFunc then
		if isLongPressOn then
			self._clickCallBackFunc(self._clickCallBackHandler, "longClickReduce", self._curIndex)
		else
			self._clickCallBackFunc(self._clickCallBackHandler, "longClickReduceFinish", self._curIndex)
		end
	end
end

function M:_onLongClickReduceExit()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "longClickReduceFinish", self._curIndex)
	end
end

function M:_clickSelectPressExit(isExit)
	return
end

return M
