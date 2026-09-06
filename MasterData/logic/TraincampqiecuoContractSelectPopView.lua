-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TraincampqiecuoContractSelectPopView.lua

module("logic.extensions.traincampqiecuo.view.TraincampqiecuoContractSelectPopView", package.seeall)

local TraincampqiecuoContractSelectPopView = class("TraincampqiecuoContractSelectPopView", ContractSelectPopView)

function TraincampqiecuoContractSelectPopView:_updateLeftList()
	local list = {}
	local positions = self._formationMo:GetPositions()
	local selectIndex = 1
	local count = 0
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))

	self:_setSummonerId(0)

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self._formationMo:_getPet(v)

			if petMo and not petMo.isMyPackPet and limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
				count = count + 1

				local element = {}

				element.index = count
				element.summonerId = v
				element.isSelect = false

				if count == 1 then
					self:_setSummonerId(v)
				end

				if self._formationMo:GetSummonPetId() == petMo.summonedPetId then
					selectIndex = count

					self:_setSummonerId(v)
				end

				table.insert(list, element)
			end
		end
	end

	if selectIndex <= #list then
		list[selectIndex].isSelect = true
	end

	self._leftScrollList:reloadData(list)
	self:_updateRightList(self._curSummonerMasterId)
end

function TraincampqiecuoContractSelectPopView:_onClickSure()
	if self._curSummonerMasterId > 0 and self._curSummonedPetId > 0 then
		local summonerPetMo = self:_getPetMo(self._curSummonerMasterId)
		local summonPetMo = self:_getPetMo(self._curSummonedPetId)

		if summonPetMo and summonerPetMo.summonedPetId and summonerPetMo.summonedPetId > 0 and summonerPetMo.summonedPetId == summonPetMo:getPetId() then
			self:_onMakeContractRes()

			return
		end

		if summonPetMo and summonPetMo.summonMasterId > 0 and summonPetMo.summonMasterId ~= summonerPetMo:getPetId() then
			local mmo = MaterialMgr.getModel(MatType.Pet, summonPetMo.summonMasterId)

			if mmo then
				local name = mmo.name

				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("当前精灵和%s绑定中，如果要契约此精灵，会先解除原契约后重新跟新的召唤师签订契约", name), function()
					TraincampqiecuoController.instance:onTrySetSummonPetBySendMsg(self._curSummonerMasterId, self._curSummonedPetId)
					self:_onClickClose()
				end)

				return
			end
		end

		TraincampqiecuoController.instance:onTrySetSummonPetBySendMsg(self._formationMo, self._curSummonerMasterId, self._curSummonedPetId)
		self:_onClickClose()
	else
		if self._curSummonerMasterId > 0 then
			local summonerPetMo = self:_getPetMo(self._curSummonerMasterId)

			if summonerPetMo then
				TraincampqiecuoController.instance:onTrySetSummonPetBySendMsg(self._formationMo, self._curSummonerMasterId, self._curSummonedPetId)
			end
		end

		self:_onClickClose()
	end
end

return TraincampqiecuoContractSelectPopView
