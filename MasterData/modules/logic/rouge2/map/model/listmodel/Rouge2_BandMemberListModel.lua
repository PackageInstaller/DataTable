-- chunkname: @modules/logic/rouge2/map/model/listmodel/Rouge2_BandMemberListModel.lua

module("modules.logic.rouge2.map.model.listmodel.Rouge2_BandMemberListModel", package.seeall)

local Rouge2_BandMemberListModel = class("Rouge2_BandMemberListModel", ListScrollModel)

function Rouge2_BandMemberListModel:initInfo(fireBandIdList)
	self._selectFireIndex = nil
	self._selectMemberIndex = nil

	self:updateInfo(fireBandIdList)
end

function Rouge2_BandMemberListModel:updateInfo(fireBandIdList)
	self:initFireMemberList(fireBandIdList)
	self:initBandMemberList()
	self:checkSelect()
end

function Rouge2_BandMemberListModel:initFireMemberList(fireBandIdList)
	self._fireBandList = {}

	for _, bandId in ipairs(fireBandIdList) do
		local bandCo = Rouge2_MapConfig.instance:getBandConfig(bandId)

		table.insert(self._fireBandList, bandCo)
	end

	table.sort(self._fireBandList, self._sortBandFunc)
end

function Rouge2_BandMemberListModel:initBandMemberList()
	self._bandHeroList = {}
	self._bandHeroMap = {}
	self._curBandCost = 0

	local bandRelicsId = Rouge2_MapConfig.instance:getBandRelicsId()
	local bandRelicsMoList = Rouge2_BackpackModel.instance:getItemListByItemId(bandRelicsId)

	if not bandRelicsMoList then
		return
	end

	for _, bandRelicsMo in ipairs(bandRelicsMoList) do
		local attrMap = bandRelicsMo:getAttrMap()

		if attrMap then
			for attrId, attrMo in pairs(attrMap) do
				local attrValue = attrMo:getValue() or 0

				if attrValue > 0 then
					local bandCo = Rouge2_MapConfig.instance:getBandConfig(attrId)

					self._bandHeroMap[attrId] = bandCo

					table.insert(self._bandHeroList, bandCo)

					if bandCo then
						if not bandCo.cost then
							local cost = 0

							self._curBandCost = self._curBandCost + cost
						end
					end
				end
			end
		end
	end

	table.sort(self._bandHeroList, self._sortBandFunc)

	if self._bandHeroList then
		if not #self._bandHeroList then
			local bandMemberNum = 0

			if bandMemberNum <= 0 then
				self:selectMember(nil)
			elseif self._selectMemberIndex ~= nil and bandMemberNum < self._selectMemberIndex then
				local selectIndex = Mathf.Clamp(self._selectMemberIndex, 1, bandMemberNum)

				self:selectMember(selectIndex)
			end
		end
	end
end

function Rouge2_BandMemberListModel._sortBandFunc(aBandCo, bBandCo)
	local aCost = aBandCo.cost
	local bCost = bBandCo.cost

	if aCost ~= bCost then
		return bCost < aCost
	end

	return aBandCo.id < bBandCo.id
end

function Rouge2_BandMemberListModel:checkSelect()
	return
end

function Rouge2_BandMemberListModel:selectFireHero(index)
	self._selectFireIndex = index

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectBandFireHero, index)
end

function Rouge2_BandMemberListModel:isSelectFireHero(index)
	return self._selectFireIndex == index
end

function Rouge2_BandMemberListModel:isBandRecruit(bandId)
	return self._bandHeroMap and self._bandHeroMap[bandId] ~= nil
end

function Rouge2_BandMemberListModel:getCurBandCost()
	return self._curBandCost
end

function Rouge2_BandMemberListModel:getFireHeroList()
	return self._fireBandList
end

function Rouge2_BandMemberListModel:getBandMemberList()
	return self._bandHeroList
end

function Rouge2_BandMemberListModel:selectMember(index)
	self._selectMemberIndex = index

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectBandMember, index)
end

function Rouge2_BandMemberListModel:isSelectMember(index)
	return self._selectMemberIndex == index
end

Rouge2_BandMemberListModel.instance = Rouge2_BandMemberListModel.New()

return Rouge2_BandMemberListModel
