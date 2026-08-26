-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaEquipItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipItem", package.seeall)

local AiZiLaEquipItem = class("AiZiLaEquipItem", LuaCompBase)

function AiZiLaEquipItem:init(go)
	self.viewGO = go
	self._gounSelected = gohelper.findChild(self.viewGO, "go_unSelected")
	self._txtunlevel = gohelper.findChildText(self.viewGO, "go_unSelected/txt_unlevel")
	self._txtunname = gohelper.findChildText(self.viewGO, "go_unSelected/txt_unname")
	self._goselected = gohelper.findChild(self.viewGO, "go_selected")
	self._txtlevel = gohelper.findChildText(self.viewGO, "go_selected/txt_level")
	self._txtname = gohelper.findChildText(self.viewGO, "go_selected/txt_name")
	self._goLeUp = gohelper.findChild(self.viewGO, "image_LvUp")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaEquipItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function AiZiLaEquipItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function AiZiLaEquipItem:_btnClickOnClick()
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectEquipType, self:getTypeId())
end

function AiZiLaEquipItem:_editableInitView()
	self._govxrefresh = gohelper.findChild(self.viewGO, "vx_refresh")
end

function AiZiLaEquipItem:onDestroy()
	return
end

function AiZiLaEquipItem:setName(name)
	self._txtunname.text = name
	self._txtname.text = name
end

function AiZiLaEquipItem:setCfg(cfg)
	self._config = cfg
	self._typeId = cfg.typeId

	self:setName(cfg.name)
end

function AiZiLaEquipItem:getTypeId()
	return self._typeId
end

function AiZiLaEquipItem:refreshUpLevel()
	self:refreshUI()
	gohelper.setActive(self._govxrefresh, false)
	gohelper.setActive(self._govxrefresh, true)
end

function AiZiLaEquipItem:refreshUI(isLockUpLevel)
	local equipMO = AiZiLaModel.instance:getEquipMO(self._typeId)

	gohelper.setActive(self._txtlevel, equipMO)
	gohelper.setActive(self._txtunlevel, equipMO)
	gohelper.setActive(self._goLeUp, isLockUpLevel ~= true and equipMO and equipMO:isCanUpLevel())

	if equipMO then
		local cfg = equipMO:getConfig()
		local level = cfg and cfg.level

		if self._lastLevel ~= level then
			self._lastLevel = level

			local levelStr = string.format("Lv.%s", level)

			self._txtlevel.text = levelStr
			self._txtunlevel.text = levelStr
		end
	end
end

function AiZiLaEquipItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
	gohelper.setActive(self._gounSelected, not isSelect)
end

return AiZiLaEquipItem
