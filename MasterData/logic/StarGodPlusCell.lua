-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/stargodplus/StarGodPlusCell.lua

module("logic.extensions.material.proxy.item.StarGodPlusCell", package.seeall)

local StarGodPlusCell = class("StarGodPlusCell", ItemCell)

function StarGodPlusCell:setData(data)
	StarGodPlusCell.super.setData(self, data)
	self:setRaceHead(self.data:getBindPetId())
end

function StarGodPlusCell:setRaceHead(raceId)
	raceId = checknumber(raceId)
	self._bindRaceId = raceId

	if raceId > 0 then
		GameUtil.SetActive(self.exclSptGo, true)
		MaterialMgr.setIcon(self.exclIcon, MatType.Pet, raceId, nil, nil)
	else
		GameUtil.SetActive(self.exclSptGo, false)
		MaterialMgr.clearIcon(self.exclIcon)
	end
end

function StarGodPlusCell:dispose()
	StarGodPlusCell.super.dispose(self)
	self:setRaceHead(0)
end

function StarGodPlusCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if not self.autoTips then
		return
	end

	local level = 0

	if self.data then
		local petId = self.data:getUsePetId()
		local fillerId = self.data:getId()
		local petMo = BagPetsController.instance:getPet(petId)

		if petMo then
			local slotDatas = petMo:getStarGodPlusSlots()

			for _, slotData in ipairs(slotDatas) do
				if slotData.fillerId == fillerId then
					level = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

					break
				end
			end
		end
	end

	CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.cfg.id, level, self._bindRaceId)
end

function StarGodPlusCell:playRareEffect(rare, parentGo)
	local url

	if rare == 5 then
		url = "fx_ui_kuang/fx_ui_kuang_chengse.prefab"
	elseif rare == 6 or rare == 7 then
		url = "fx_ui_kuang/fx_ui_kuang_hongse.prefab"
	end

	return self:playCellEffect(url, parentGo)
end

return StarGodPlusCell
