-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/view/ItemSignReward.lua

module("logic.extensions.weekreward.view.ItemSignReward", package.seeall)

local ItemSignReward = class("ItemSignReward")
local day = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七"
}

function ItemSignReward:ctor(target, view)
	self._target = target
	self._btn = Framework.ButtonAdapter.GetFrom(self._target, "ImgC_Icon")
	self._ImgC_Icon = goutil.findChildComponent(self._target, "ImgC_Icon", "Image")
	self._TxtC_Num = goutil.findChildTextComponent(self._target, "TxtC_Num")
	self._TxtC_Day = goutil.findChildTextComponent(self._target, "TxtC_Day")
	self._Nego_CanSign = goutil.findChild(self._target, "Nego_CanSign")
	self._Nego_Received = goutil.findChild(self._target, "Nego_Received")
	self._Nego_Locked = goutil.findChild(self._target, "Nego_Locked")
	self._Nego_Special = goutil.findChild(self._target, "Nego_Special")
	self.view = view
	self._txtName = goutil.findChildTextComponent(self._target, "txtName")
	self._cellEffect = PhotoEffect.Get(goutil.findChild(self._target, "celleffect"))

	self._cellEffect._go:SetActive(false)
end

function ItemSignReward:SetData(data)
	local key = data
	local prizeDay = WeekRewardModel.instance:getPrizedDay()
	local loginDays = WeekRewardModel.instance:getLoginDays()
	local offset = math.floor(prizeDay / 7) * 7

	offset = math.min(7, offset)

	if offset < loginDays then
		key = key + offset
	end

	local cfg = ActivityParamsConfig.instance:getSignInCfgByKey(tostring(key))

	self._day = checknumber(cfg.value.day)
	self._islarge = checknumber(cfg.value.islarge) == 1
	self._bIsReceived = prizeDay >= self._day
	self._bCanReceive = self._day == prizeDay + 1 and loginDays >= self._day

	self._Nego_Special:SetActive(self._islarge and true or false)

	self._TxtC_Day.text = string.format("<color=#%s>第%s天</color>", self._bCanReceive and "FFC64D" or "FFFFFF", day[(self._day - 1) % 7 + 1])

	self._Nego_Received:SetActive(self._bIsReceived)
	self._Nego_CanSign:SetActive(false)

	if self._bIsReceived or self._bCanReceive then
		self._Nego_Locked:SetActive(false)
	else
		self._Nego_Locked:SetActive(true)
	end

	local itemStr = string.gsub(cfg.value.material, "=", ":")
	local itemTable = string.split(itemStr, ":")
	local resPath = self._bCanReceive and "effect/prefabs/ui/fx_ui_7ri/fx_ui_fangkuai_yellow.prefab" or "effect/prefabs/ui/fx_ui_7ri/fx_ui_fangkuai_blue.prefab"

	self._cellEffect:showEffects(resPath)
	self._cellEffect:setCameraPosition(0, 0, -344)

	local matType = checknumber(itemTable[1])
	local matId = checknumber(itemTable[2])
	local num = checknumber(itemTable[3])
	local cfg = MaterialFacade.instance:getMatCfg(matType, matId)

	self._txtName.text = string.format("<color=#%s>%s</color>", self._bCanReceive and "FFC64D" or "FFFFFF", (cfg or nil) and (cfg.name .. "x" .. num or ""))

	MaterialMgr.setIcon(self._ImgC_Icon, matType, matId)

	self._TxtC_Num.text = (matType == MatType.PokeBall or matType == MatType.Item or matType == MatType.Coin or matType == MatType.Diamond or matType == MatType.Pack) and (num > 1 and tostring(num) or "") or ""

	self._btn:RemoveClickListener()
	self._btn:AddClickListener(function()
		self:onClickSignIn(itemStr)
	end)
end

function ItemSignReward:bindEvents()
	return
end

function ItemSignReward:removeEvents()
	return
end

function ItemSignReward:Dispose()
	self._cellEffect:clear()
	self._btn:RemoveClickListener()
end

function ItemSignReward:onClickSignIn(itemStr)
	if self._bCanReceive then
		WeekRewardAgent.instance:sendSignInGainPrizeReq()
	else
		CommonTipsMgr.instance:openTipsByConfStr(self._btn, itemStr)
	end
end

return ItemSignReward
