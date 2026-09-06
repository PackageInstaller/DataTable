-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooWorkingView.lua

module("logic.extensions.zoo.view.ZooWorkingView", package.seeall)

local ZooWorkingView = class("ZooWorkingView", ViewComponent)

function ZooWorkingView:buildUI()
	ZooWorkingView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._itemCon = self:getGo("right")
	self._itemList = {}

	for i = 1, 4 do
		self._itemList[i] = GameUtil.AddLuaOnce(self:getGo("right/cell_" .. i), ZooWorkingItem)
	end

	self._productionNum = self:getTxt("productionNum")
	self._workerNumNum = self:getTxt("workerNumNum")

	local production = self:getTxt("production")
	local workerNum = self:getTxt("workerNum")

	production.text = lang("petzoo_working_currratetips")
	workerNum.text = lang("petzoo_working_currworkingtips")
end

function ZooWorkingView:bindEvents()
	ZooWorkingView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZooWorkingView:unbindEvents()
	ZooWorkingView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZooWorkingView:destroyUI()
	ZooWorkingView.super.destroyUI(self)

	for i, v in ipairs(self._itemList) do
		v:onExit()
		GameUtil.RemoveLua(v.mainGO, ZooWorkingItem)
	end

	self._itemList = {}
end

function ZooWorkingView:onEnter()
	ZooWorkingView.super.onEnter(self)

	self._buildingMO = self:getFirstParam()

	if not self._buildingMO.workAnimalIds then
		local maxNum = self._buildingMO:getMaxWorkerNum()

		for i, v in ipairs(self._itemList) do
			local animalMo

			v:onEnter(i, (checknumber(self._buildingMO.workAnimalIds[i]) > 0 or nil) and self._buildingMO.zooMo:getAnimalById(self._buildingMO.workAnimalIds[i]), self._buildingMO)
			v:setLock(maxNum < i)
		end

		self:_updateWorkingInfo()
		GlobalDispatcher:addListener(GlobalNotify.OnPutAnimalToWork, self._onPutAnimalToWork, self)
	end
end

function ZooWorkingView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnPutAnimalToWork, self._onPutAnimalToWork, self)
	ZooWorkingView.super.onExit(self)

	for i, v in ipairs(self._itemList) do
		v:onExit()
	end
end

function ZooWorkingView:_updateWorkingInfo()
	self._productionNum.text = string.format(lang("petzoo_working_production_spd"), self._buildingMO:getCurrScoreSpeed())
	self._workerNumNum.text = tostring(self._buildingMO.currWorkerNum)
end

function ZooWorkingView:_onPutAnimalToWork()
	self:_updateWorkingInfo()
end

return ZooWorkingView
