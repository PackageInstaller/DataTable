-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculateRewardItem.lua

module("logic.extensions.battle.viewcalculate.BattleCalculateRewardItem", package.seeall)

local M = class("BattleCalculateRewardItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buidUI()
end

function M:OnDestroy()
	self:destroyUI()

	self.mainGO = false
end

function M:buidUI()
	self._rectTran = goutil.addComponentOnce(self.mainGO, goutil.Type_RectTransform)

	local isWin = BattleCalculateModel.instance:isWin()

	RectTransformUtils.SetAnchoredPosition(self.mainGO.transform, isWin and 58 or 0, isWin and 225 or 0)

	self._itemCell = Astral.SimpleLuaComponentContainer.Add(self.mainGO, BattleCalculateRewardCell)

	self._itemCell:_addComponent("sign", ItemSignComponent)
	self._itemCell:Awake()
end

function M:destroyUI()
	return
end

function M:setItemMO(data)
	self._data = data

	self._itemCell:updateData(data)
	self._itemCell:setShowSelectedEffect(false)
	self._itemCell:getComponent("num"):updateData(data)
end

function M:setSignShow(signTyp)
	signTyp = signTyp == 3 and 2 or signTyp

	self._itemCell:getComponent("sign"):setSignShow(signTyp, true)
end

function M:getRectTran()
	return self._rectTran
end

function M:setClickHeight(v)
	if self._itemCell:getComponent("normal") then
		self._itemCell:getComponent("normal"):setClickHeight(v)
	end
end

function M:refreshLock()
	local data = self._data
	local uuid = data:getUuid()

	if uuid then
		-- block empty
	end
end

return M
