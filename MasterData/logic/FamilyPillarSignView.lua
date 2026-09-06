-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarSignView.lua

module("logic.extensions.newfamily.view.war.FamilyPillarSignView", package.seeall)

local FamilyPillarSignView = class("FamilyPillarSignView", ViewComponent)

function FamilyPillarSignView:ctor()
	FamilyPillarSignView.super.ctor(self)

	self._pillarItemList = nil
	self._familyIds = nil
	self._clickTimer = nil
end

function FamilyPillarSignView:bindEvents()
	FamilyPillarSignView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i = 1, #self._pillarItemList do
		if self._pillarItemList[i] and self._pillarItemList[i].attackBtn then
			self._pillarItemList[i].attackBtn:AddClickListener(function()
				self:_onClickAttackBtn(i)
			end, self)
		end

		if self._pillarItemList[i] and self._pillarItemList[i].defenseBtn then
			self._pillarItemList[i].defenseBtn:AddClickListener(function()
				self:_onClickDefenseBtn(i)
			end, self)
		end
	end
end

function FamilyPillarSignView:unbindEvents()
	FamilyPillarSignView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for _, item in pairs(self._pillarItemList or {}) do
		if item and item.attackBtn then
			item.attackBtn:RemoveClickListener()
		end

		if item and item.defenseBtn then
			item.defenseBtn:RemoveClickListener()
		end
	end
end

function FamilyPillarSignView:onExit()
	FamilyPillarSignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarPillarSign, self._updataShowPillarSign, self)

	for _, item in pairs(self._pillarItemList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	self._familyIds = nil
	self._clickTimer = nil
end

function FamilyPillarSignView:destroyUI()
	FamilyPillarSignView.super.destroyUI(self)

	self._pillarItemList = nil
end

function FamilyPillarSignView:buildUI()
	FamilyPillarSignView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._pillarItemList = {}

	for i = 1, 4 do
		local itemGo = self:getGo("pillarGo_" .. i)

		self._pillarItemList[i] = {
			itemGo = itemGo,
			iconGo = goutil.findChild(itemGo, "iconGo"),
			nameTxt = goutil.findChildTextComponent(itemGo, "nameTxt"),
			countTxt = goutil.findChildTextComponent(itemGo, "countTxt"),
			attackBtn = Framework.ButtonAdapter.GetFrom(itemGo, "attackBtn"),
			defenseBtn = Framework.ButtonAdapter.GetFrom(itemGo, "defenseBtn")
		}
	end
end

function FamilyPillarSignView:onEnter()
	FamilyPillarSignView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarPillarSign, self._updataShowPillarSign, self)

	local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()
	local count = #baseInfo.pillarInfos
	local index = 0

	self._familyIds = {}

	local cfg

	for i = 1, count do
		if baseInfo.pillarInfos and baseInfo.pillarInfos[i] and baseInfo.pillarInfos[i].familyId ~= baseInfo.myFamilyId then
			index = index + 1

			if self._pillarItemList[index] and self._pillarItemList[index].itemGo then
				GameUtil.SetActive(self._pillarItemList[index].itemGo, true)

				self._pillarItemList[index].nameTxt.text = baseInfo.pillarInfos[i].familyName
				self._pillarItemList[index].countTxt.text = "家族能量" .. baseInfo.pillarInfos[i].totalEnergy
				self._familyIds[baseInfo.pillarInfos[i].familyId] = index
				cfg = FamilyWarConfig.instance:getFamilyPillarInfoCfgs(i)

				if cfg then
					local path = string.format("ui/bigbg/familynesttower/%s.png", cfg.midIcon or "board_llzz_03")

					uGuiUtil.setSpriteToImage(self._pillarItemList[index].iconGo, uGuiUtil.SpriteType.BigBg, path)
				end
			end
		end
	end

	if index < #self._pillarItemList then
		for i = index + 1, #self._pillarItemList do
			GameUtil.SetActive(self._pillarItemList[i].itemGo, false)
		end
	end

	self:_updataShowPillarSign(baseInfo.flagFamilyId, baseInfo.noFlagFamilyId)
end

function FamilyPillarSignView:_updataShowPillarSign(attId, noAttId)
	local attIndex, defIndex = 0, 0

	if attId > 0 and self._familyIds[attId] then
		attIndex = self._familyIds[attId]
	end

	if noAttId > 0 and self._familyIds[noAttId] then
		defIndex = self._familyIds[noAttId]
	end

	for i = 1, #self._pillarItemList do
		if self._pillarItemList[i] and self._pillarItemList[i].attackBtn then
			uGuiUtil.setImageGrayStateRecursive(self._pillarItemList[i].attackBtn.gameObject, i ~= checknumber(attIndex))
		end
	end

	for i = 1, #self._pillarItemList do
		if self._pillarItemList[i] and self._pillarItemList[i].defenseBtn then
			uGuiUtil.setImageGrayStateRecursive(self._pillarItemList[i].defenseBtn.gameObject, i ~= checknumber(defIndex))
		end
	end
end

function FamilyPillarSignView:_onClickAttackBtn(index)
	if not self:_preventTooFastClick() then
		return
	end

	local attId, noAttId = FamilyWarModel.instance:getFamilyWarPillarSign()
	local nowId = 0

	for id, num in pairs(self._familyIds or {}) do
		if checknumber(num) == index then
			nowId = id

			break
		end
	end

	if nowId == attId then
		FamilyWarController:csRequestFamilyBattleSetFlagReq(0, noAttId)

		return
	end

	if nowId == noAttId then
		FamilyWarController:csRequestFamilyBattleSetFlagReq(nowId, 0)

		return
	end

	FamilyWarController:csRequestFamilyBattleSetFlagReq(nowId, noAttId)
end

function FamilyPillarSignView:_onClickDefenseBtn(index)
	if not self:_preventTooFastClick() then
		return
	end

	local attId, noAttId = FamilyWarModel.instance:getFamilyWarPillarSign()
	local nowId = 0

	for id, num in pairs(self._familyIds or {}) do
		if checknumber(num) == index then
			nowId = id

			break
		end
	end

	if nowId == noAttId then
		FamilyWarController:csRequestFamilyBattleSetFlagReq(attId, 0)

		return
	end

	if nowId == attId then
		FamilyWarController:csRequestFamilyBattleSetFlagReq(0, nowId)

		return
	end

	FamilyWarController:csRequestFamilyBattleSetFlagReq(attId, nowId)
end

function FamilyPillarSignView:_preventTooFastClick(isTips)
	local now = ServerTime.now()

	if checknumber(self._clickTimer) == 0 then
		self._clickTimer = now
	else
		if now - self._clickTimer < 0.8 then
			if not isTips then
				FloatWordMgr.instance:show("点击过于频繁")
			end

			return false
		end

		self._clickTimer = now
	end

	return true
end

return FamilyPillarSignView
