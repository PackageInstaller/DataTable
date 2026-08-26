-- chunkname: @modules/logic/toughbattle/view/ToughBattleRoleListComp.lua

module("modules.logic.toughbattle.view.ToughBattleRoleListComp", package.seeall)

local ToughBattleRoleListComp = class("ToughBattleRoleListComp", LuaCompBase)

function ToughBattleRoleListComp:ctor(param)
	self.viewParam = param
end

function ToughBattleRoleListComp:init(go)
	self.go = go
	self._anim = gohelper.findChild(go, "root"):GetComponent(typeof(UnityEngine.Animator))

	local parent = gohelper.findChild(go, "root/#go_rolelist")
	local item = gohelper.findChild(parent, "#go_item")

	self._items = self:getUserDataTb_()

	local info = self:getInfo()
	local data = {}
	local configDict = self.viewParam.mode == ToughBattleEnum.Mode.Act and lua_activity158_challenge.configDict or lua_siege_battle.configDict

	for i = 1, 3 do
		local co = configDict[info.passChallengeIds[i]]
		local isNewGet = co and co.sort == self.viewParam.lastFightSuccIndex

		data[i] = {
			co = co,
			isNewGet = isNewGet
		}
	end

	gohelper.CreateObjList(self, self.createItem, data, parent, item, ToughBattleRoleItem)
	self:setSelect(self._selectCo)
end

function ToughBattleRoleListComp:getInfo()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_3_0 = ToughBattleModel.instance:getActInfo()

		if not var_3_0 then
			var_3_0 = ToughBattleModel.instance:getStoryInfo()

			return var_3_0
		end
	end
end

function ToughBattleRoleListComp:createItem(comp, data, index)
	self._items[index] = comp

	self._items[index]:initData(data)
	self._items[index]:setClickCallBack(self._onItemClick, self)
end

function ToughBattleRoleListComp:_onItemClick(co)
	if self._clickCallBack then
		self._clickCallBack(self._callobj, co)
	end
end

function ToughBattleRoleListComp:setClickCallBack(callback, callobj)
	self._clickCallBack = callback
	self._callobj = callobj
end

function ToughBattleRoleListComp:setSelect(co)
	self._selectCo = co

	if self._items then
		for i = 1, #self._items do
			self._items[i]:setSelect(co)
		end
	end
end

function ToughBattleRoleListComp:playAnim(animName)
	if not self._anim then
		return
	end

	self._anim:Play(animName, 0, 0)

	if animName == "open" and self._items then
		for i = 1, #self._items do
			self._items[i]:playFirstAnim()
		end
	end
end

function ToughBattleRoleListComp:onDestroy()
	self._clickCallBack = nil
	self._callobj = nil
end

return ToughBattleRoleListComp
