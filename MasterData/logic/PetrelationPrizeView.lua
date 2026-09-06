-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationPrizeView.lua

module("logic.extensions.petrelation.view.PetrelationPrizeView", package.seeall)

local PetrelationPrizeView = class("PetrelationPrizeView", ViewComponent)

function PetrelationPrizeView:ctor()
	PetrelationPrizeView.super.ctor(self)
end

function PetrelationPrizeView:buildUI()
	PetrelationPrizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._prizeCell = self:getGo("prizeCell")
	self._prizeView = ScrollerList.create(self:getGo("prizeView"), self._prizeCell, GameUtil.handler(self._updatePrize, self))
	self._prizePetHead = self:getGo("pet")
end

function PetrelationPrizeView:bindEvents()
	PetrelationPrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PetrelationPrizeView:unbindEvents()
	PetrelationPrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PetrelationPrizeView:destroyUI()
	PetrelationPrizeView.super.destroyUI(self)
end

function PetrelationPrizeView:onEnter()
	PetrelationPrizeView.super.onEnter(self)

	self._petView = {}
	self._prizeInfo = PetRelationConfig.instance:getGroupPrize()

	PetManualAgent.instance:sendUserGroupInfoReq(self._handerprizeInfo, self)
end

function PetrelationPrizeView:onEnterFinished()
	PetrelationPrizeView.super.onEnterFinished(self)
end

function PetrelationPrizeView:onExit()
	PetrelationPrizeView.super.onExit(self)
	self._prizeView:dispose()

	if self._petView then
		for k, v in pairs(self._petView) do
			v:dispose()
		end
	end
end

function PetrelationPrizeView:onExitFinished()
	PetrelationPrizeView.super.onExitFinished(self)
end

function PetrelationPrizeView:_updatePrize(view, cell, data, tag)
	goutil.findChildTextComponent(cell, "name").text = data.name

	if self._petView[cell] == nil then
		self._petView[cell] = ScrollerList.create(goutil.findChild(cell, "petView"), self._prizePetHead, GameUtil.handler(self._updatePetHead, self))

		self._petView[cell]:reloadData(data.needRaceIds)
	else
		self._petView[cell]:reloadData(data.needRaceIds)
	end

	local receiveBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "receiveBtn")

	goutil.setActive(receiveBtn.gameObject, data.status == 1)
	receiveBtn:RemoveClickListener()

	if data.status == 1 then
		receiveBtn:AddClickListener(function()
			PetManualAgent.instance:sendGainGroupPrizeReq(data.groupId, function()
				self:_gainGroupPrize(data.groupId)
			end)
		end)
	end

	goutil.setActive(goutil.findChild(cell, "uncomplete"), data.status == 2)
	goutil.setActive(goutil.findChild(cell, "complete"), data.status == 3)

	local prizeList = string.split(data.prize, "#")

	for i = 1, 4 do
		local prize = goutil.findChild(cell, "prizeList/prize_" .. i)

		if prizeList[i] then
			local proxy = MaterialMgr.setCellByCfg(prizeList[i], prize)

			Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.8, 0.8, 1)
			goutil.setActive(prize, true)
		else
			goutil.setActive(prize, false)
		end
	end
end

function PetrelationPrizeView:_updatePetHead(view, cell, data, tag)
	local petCo = CharacterConfig.instance:getPetCo(data)

	if petCo then
		local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, petCo.raceId)

		goutil.findChildComponent(cell, "", "UIImageSpriteChange"):SetState(rare + 1)

		local modelCo = CharacterConfig.instance:getModelCo(tonumber(petCo.faceIds))

		uGuiUtil.setSpriteToImage(goutil.findChild(cell, "mask/head"), uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		uGuiUtil.setImageGrayState(cell, not HandbookModel.instance:isHasPet(data))
	else
		printError(string.format("未找到id:%d的精灵信息", data))
	end
end

function PetrelationPrizeView:_handerprizeInfo(msg)
	for i, v in ipairs(msg.groupId) do
		self._prizeInfo[v].status = 3
	end

	for i, info in ipairs(self._prizeInfo) do
		if not info.status then
			local flag = true

			for i, raceId in ipairs(info.needRaceIds) do
				if not HandbookModel.instance:isHasPet(raceId) then
					flag = false

					break
				end
			end

			info.status = flag and 1 or 2
		end
	end

	table.sort(self._prizeInfo, function(a, b)
		return a.status < b.status
	end)
	self._prizeView:reloadData(self._prizeInfo)
end

function PetrelationPrizeView:_gainGroupPrize(groupId)
	for i, info in ipairs(self._prizeInfo) do
		if info.groupId == groupId then
			info.status = 3

			break
		end
	end

	table.sort(self._prizeInfo, function(a, b)
		return a.status < b.status
	end)
	self._prizeView:reloadData(self._prizeInfo)
end

return PetrelationPrizeView
