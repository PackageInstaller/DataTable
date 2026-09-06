-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickItemView.lua

module("logic.extensions.pickapet.view.PickItemView", package.seeall)

local PickItemView = class("PickItemView")

function PickItemView:ctor(target)
	self._target = target
	self.ImgC_Selected = goutil.findChild(self._target, "ImgC_Selected")
	self.iconGo = goutil.findChild(self._target, "icon")
	self.btn = goutil.findChild(self._target, "imgBg")

	GameUtil.asBtn(self.btn):AddClickListener(self._OnClick, self)
end

function PickItemView:Init(pet, ignore)
	self._data = pet

	local isEmpty = not pet

	GameUtil.SetActive(self.iconGo, false)

	if isEmpty then
		return
	end

	GameUtil.SetActive(self.iconGo, true)
	MaterialMgr.setIcon(self.iconGo, MatType.Pet, pet.raceId)

	self._selected = false
end

function PickItemView:setSelected(boo)
	GameUtil.SetActive(self.ImgC_Selected, boo)
end

function PickItemView:setCallBack(cb)
	self.callBack = cb
end

function PickItemView:addClickCallBack(cb)
	self.clickCallBack = cb
end

function PickItemView:_OnClick()
	if self._selected or self._ignore then
		return
	end

	self._selected = true

	self:setSelected(true)
	GameUtil.callBack(self.clickCallBack, self._data)
	PickAPetModel.instance:dealPickPet(self._data.raceId, self._target, self.callBack)
end

function PickItemView:itemTag(tag)
	self._tag = tag
end

function PickItemView:OnSelectPetChanged(tag)
	if not self._data then
		return
	end

	self:setSelected(self._tag == tag)
end

function PickItemView:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self._target, isGray)
end

return PickItemView
