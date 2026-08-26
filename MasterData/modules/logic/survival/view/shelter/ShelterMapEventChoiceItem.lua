-- chunkname: @modules/logic/survival/view/shelter/ShelterMapEventChoiceItem.lua

module("modules.logic.survival.view.shelter.ShelterMapEventChoiceItem", package.seeall)

local ShelterMapEventChoiceItem = class("ShelterMapEventChoiceItem", SurvivalEventChoiceItem)

function ShelterMapEventChoiceItem:init(go)
	self.go = go
	self._btn = gohelper.findChildButtonWithAudio(go, "#go_State")
	self._gobgyellow = gohelper.findChild(go, "#go_State/#go_bg_yellow")
	self._gobgred = gohelper.findChild(go, "#go_State/#go_bg_red")
	self._gobggreen = gohelper.findChild(go, "#go_State/#go_bg_green")
	self._gobggray = gohelper.findChild(go, "#go_State/#go_bg_gray")
	self._gonormal = gohelper.findChild(go, "#go_State/#go_normal")
	self._txtnormaldesc = gohelper.findChildTextMesh(go, "#go_State/#go_normal/#txt_desc")
	self._txt_desc_lock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_lock")
	self._txt_condition_lock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_lock/#txt_condition_lock")
	self._go_costtime_lock = gohelper.findChild(go, "#go_State/#txt_desc_lock/#go_costTime")
	self._txt_costtime_lock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_lock/#go_costTime/#txt_Time")
	self._txt_desc_unlock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_unlock")
	self._txt_condition_unlock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_unlock/#txt_condition_unlock")
	self._go_costtime_unlock = gohelper.findChild(go, "#go_State/#txt_desc_unlock/#go_costTime")
	self._txt_costtime_unlock = gohelper.findChildTextMesh(go, "#go_State/#txt_desc_unlock/#go_costTime/#txt_Time")
	self._goicon = gohelper.findChild(go, "#go_State/#go_Icon")
end

function ShelterMapEventChoiceItem:addEventListeners()
	self._btn:AddClickListener(self._onClick, self)
end

function ShelterMapEventChoiceItem:removeEventListeners()
	self._btn:RemoveClickListener()
end

function ShelterMapEventChoiceItem:updateData(data)
	self.data = data

	gohelper.setActive(self.go, data)

	if data then
		local color = data.color

		gohelper.setActive(self._gobgred, color == SurvivalConst.EventChoiceColor.Red)
		gohelper.setActive(self._gobgyellow, color == SurvivalConst.EventChoiceColor.Yellow)
		gohelper.setActive(self._gobggreen, color == SurvivalConst.EventChoiceColor.Green)
		gohelper.setActive(self._gobggray, color == SurvivalConst.EventChoiceColor.Gray)
		gohelper.setActive(self._gonormal, data.exStr == nil)
		gohelper.setActive(self._txt_desc_unlock, data.exStr and data.isValid)
		gohelper.setActive(self._txt_desc_lock, data.exStr and not data.isValid)
		gohelper.setActive(self._goicon, data.icon ~= SurvivalEnum.EventChoiceIcon.None)

		if not data.exStr then
			self._txtnormaldesc.text = data.desc
		elseif data.isValid then
			self._txt_desc_unlock.text = data.desc

			gohelper.setActive(self._go_costtime_unlock, data.isCostTime)
			gohelper.setActive(self._txt_condition_unlock, not data.isCostTime)

			if data.isCostTime then
				self._txt_costtime_unlock.text = data.exStr
			else
				self._txt_condition_unlock.text = data.exStr
			end
		else
			self._txt_desc_lock.text = data.desc

			gohelper.setActive(self._go_costtime_lock, data.isCostTime)
			gohelper.setActive(self._txt_condition_lock, not data.isCostTime)

			if data.isCostTime then
				self._txt_costtime_lock.text = data.exStr
			else
				self._txt_condition_lock.text = data.exStr
			end
		end
	end
end

function ShelterMapEventChoiceItem:_onClick()
	if not self.data.isValid then
		return
	end

	if self.data.callback then
		self.data.callback(self.data.callobj, self.data.param, self.data)
	end
end

return ShelterMapEventChoiceItem
