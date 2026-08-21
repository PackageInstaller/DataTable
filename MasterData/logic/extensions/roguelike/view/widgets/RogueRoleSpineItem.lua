-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleSpineItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleSpineItem", package.seeall)

local M = class("RogueRoleSpineItem")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Awake()
	self:onInit(self._go)
end

function M:onInit(go)
	self._txtHp = goutil.findChildComponent(go, "hp/txtHp", UIComponentType.Text)
	self._txtSan = goutil.findChildComponent(go, "san/txtSan", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._goRoleSpine = goutil.findChild(go, "smallSpine/RawImage")
	self._spineRole = UISpine.Get(self._goRoleSpine)

	self:bindEvents()
end

function M:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setHp(hp)
	self._txtHp.text = hp
end

function M:setSan(san)
	self._txtSan.text = san
end

function M:setSpine(roleId)
	goutil.setActive(self._goRoleSpine, false)
end

function M:updateData(data)
	local roleId = data.roleId

	self._index = data.index
	self._clickCallback = data.callback

	local prop = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId).roleProp

	self:setHp(prop:getHp())
	self:setSan(prop:getSan())
	self:setSpine(roleId)
	goutil.setActive(self._go, true)
end

function M:onClick()
	if self._clickCallback then
		self._clickCallback(self._index)
	end
end

function M:OnDestroy()
	self._spineRole:clear()
	self:unbindEvents()

	self._txtHp = nil
	self._txtSan = nil
	self._btnClick = nil
	self._goRoleSpine = nil
	self._spineRole = nil
end

return M
