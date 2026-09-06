-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/ItemMatsGrid.lua

module("logic.extensions.starequipment.view.ItemMatsGrid", package.seeall)

local ItemMatsGrid = class("ItemMatsGrid")

function ItemMatsGrid:ctor(target, clickCall)
	self.mainGO = target

	local childCount = target.transform.childCount

	self._mats = {}

	for i = 1, childCount do
		local mat = {}
		local go = target.transform:GetChild(i - 1).gameObject

		mat.mainGO = go
		mat.txtProgress = goutil.findChildComponent(go, "txtNum", "Text")
		mat.itemPoint = goutil.findChild(go, "itemPoint")
		mat.imgAdd = goutil.findChild(go, "img_add")

		goutil.setActive(go, false)
		table.insert(self._mats, mat)
	end

	self._clickCall = clickCall
end

function ItemMatsGrid:onSetMo(matStr)
	local i = 1

	self._isMatEnough = true
	self._curMatStr = matStr

	local t = string.split(matStr, "#")

	for _, v in ipairs(t) do
		local matMo = string.split(v, ":")
		local matType = checknumber(matMo[1])
		local matId = checknumber(matMo[2])
		local matNum = checknumber(matMo[3])
		local mat = self._mats[i]
		local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s:0", matType, matId), mat.itemPoint)

		goutil.setActive(mat.mainGO, true)

		local curNum = MaterialFacade.instance:getMatNumber(matType, matId)
		local color = matNum <= curNum and "0068B7FF" or "ff0000"

		mat.txtProgress.text = string.format("<color=#%s>%s</color>/%s", color, curNum, matNum)
		i = i + 1

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setCallBack(function()
				if self._clickCall ~= nil then
					self._clickCall()
				end

				MaterialMgr.openGetSource(matType, matId)
			end)
		end

		self._isMatEnough = self._isMatEnough and matNum <= curNum

		goutil.setActive(mat.imgAdd, curNum < matNum)
	end

	for j = i, #self._mats do
		goutil.setActive(self._mats[j].mainGO, false)
	end
end

function ItemMatsGrid:getMatsIsEnough()
	return self._isMatEnough == true
end

function ItemMatsGrid:isOneGainWayAtLeast()
	local matStr = self._curMatStr

	if string.nilorempty(matStr) then
		return false
	end

	local itemStrList = string.split(matStr, "#")

	for i, v in ipairs(itemStrList) do
		local matMo = string.split(v, ":")
		local matType = checknumber(matMo[1])
		local matId = checknumber(matMo[2])

		if not PlotCopyModel.instance:isOneWaySweepExistAtLeast(matType, matId) then
			return false
		end
	end

	return true
end

return ItemMatsGrid
