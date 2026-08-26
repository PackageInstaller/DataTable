-- chunkname: @modules/logic/meilanni/view/MeilanniEventItem.lua

module("modules.logic.meilanni.view.MeilanniEventItem", package.seeall)

local MeilanniEventItem = class("MeilanniEventItem", ListScrollCellExtend)

function MeilanniEventItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "icon/#image_icon")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_info/#txt_title")
	self._imagephoto = gohelper.findChildImage(self.viewGO, "#image_photo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniEventItem:addEvents()
	return
end

function MeilanniEventItem:removeEvents()
	return
end

function MeilanniEventItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function MeilanniEventItem:setPhotoVisible(value)
	gohelper.setActive(self._imagephoto.gameObject, self._showModel and value)
end

function MeilanniEventItem:playAnim(name)
	self._animator:Play(name)
end

function MeilanniEventItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function MeilanniEventItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function MeilanniEventItem:_onClick()
	if self._clickEnabled == false then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.resetDialogPos)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.clickEventItem, self)
end

function MeilanniEventItem:isSelected()
	return self._isSelected
end

function MeilanniEventItem:setSelected(value)
	self._isSelected = value

	if value then
		local yellow = gohelper.findChild(self.viewGO, "icon/glow/glow_yellow")
		local red = gohelper.findChild(self.viewGO, "icon/glow/glow_red")

		gohelper.setActive(yellow, self._config.type ~= 1)
		gohelper.setActive(red, self._config.type == 1)
		self:playAnim("select")
	else
		self:playAnim("unselect")
	end
end

function MeilanniEventItem:setClickEnabled(value)
	self._clickEnabled = value
end

function MeilanniEventItem:setGray(value)
	if self._speicalType then
		return
	end

	UISpriteSetMgr.instance:setMeilanniSprite(self._imageicon, value and "bg_tanhao_1" or "bg_tanhaohui")
end

function MeilanniEventItem:isSpecialType()
	return self._speicalType
end

function MeilanniEventItem:updateInfo(info)
	self._info = info
	self._eventId = self._info.eventId
	self._config = lua_activity108_event.configDict[self._eventId]

	local offsetPos = string.splitToNumber(self._config.pos, "#")

	if not offsetPos[1] then
		if not offsetPos[2] then
			local offsetY = 0

			transformhelper.setLocalPos(self.viewGO.transform, offsetPos[1], offsetY, 0)

			self._speicalType = self._config.type == 1

			UISpriteSetMgr.instance:setMeilanniSprite(self._imageicon, self._speicalType and "bg_tanhao" or "bg_tanhao_1")

			if self._speicalType then
				recthelper.setAnchorX(self._imageicon.transform, -11)
			end

			local showModel = not string.nilorempty(self._config.model)

			self._showModel = showModel

			gohelper.setActive(self._imagephoto.gameObject, showModel)

			if showModel then
				UISpriteSetMgr.instance:setMeilanniSprite(self._imagephoto, self._config.model)

				local offsetPos = string.splitToNumber(self._config.modelPos, "#")

				if not offsetPos[1] then
					if not offsetPos[2] then
						local offsetY = 0

						transformhelper.setLocalPos(self._imagephoto.transform, offsetPos[1], offsetY, 0)
					end
				end
			end

			if not string.nilorempty(self._config.title) then
				gohelper.setActive(self._goinfo, true)

				self._txttitle.text = self._config.title
			end
		end
	end
end

function MeilanniEventItem:_updateImage()
	return
end

function MeilanniEventItem:dispose()
	if not self.viewGO.activeSelf then
		gohelper.destroy(self.viewGO)

		return
	end

	gohelper.setActive(self._imagephoto.gameObject, false)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._animatorPlayer:Play("disappear", self._disappear, self)
end

function MeilanniEventItem:_disappear()
	gohelper.destroy(self.viewGO)
end

function MeilanniEventItem:onDestroyView()
	return
end

return MeilanniEventItem
