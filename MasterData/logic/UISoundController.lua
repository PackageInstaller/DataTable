-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uisound/controller/UISoundController.lua

module("logic.extensions.uisound.controller.UISoundController", package.seeall)

local UISoundController = class("UISoundController", BaseController)

function UISoundController:onInit()
	UISoundController.super.onInit(self)
	Framework.UIClickTrigger.AddGlobalClickListener(self._onClickButton, self)
	Framework.ButtonAdapter.AddGlobalClickListener(self._onClickButton, self)
	Framework.ToggleAdapter.AddGlobalClickListener(self._onClickToggle, self)
	self.registerNotify(self, GlobalNotify.SpreadButton, self._onSpreadButton, self)
end

function UISoundController:_onClickButton(gameObject)
	local img = gameObject:GetComponent(goutil.Type_UIImage)
	local soundSoundId

	if img and not goutil.isNil(img.sprite) then
		soundSoundId = UISoundModel.instance:getClickSoundId(gameObject, img.sprite.name)
	end

	if not soundSoundId then
		local imgs = gameObject:GetComponentsInChildren(goutil.Type_UIImage)

		for i = 0, imgs.Length - 1 do
			if not goutil.isNil(imgs[i].sprite) then
				soundSoundId = UISoundModel.instance:getClickSoundId(gameObject, imgs[i].sprite.name)
			end

			if soundSoundId then
				break
			end
		end
	end

	soundSoundId = soundSoundId or 30001

	AudioPlayerEx.instance:playEffect(soundSoundId)
end

function UISoundController:_onClickToggle(gameObject)
	local hitUI = UGUIToolHelper.IsHitVisibleUI()

	if hitUI and (hitUI == gameObject or hitUI.transform:IsChildOf(gameObject.transform)) then
		AudioPlayerEx.instance:playEffect(30013)
	end
end

function UISoundController:_onViewOpened(view)
	local soundId = UISoundModel.instance:getViewOpenSoundId(view)

	if soundId then
		AudioPlayerEx.instance:playEffect(soundId)
	end
end

function UISoundController:_onSpreadButton(isSpread)
	if isSpread then
		AudioPlayerEx.instance:playEffect(30006)
	else
		AudioPlayerEx.instance:playEffect(30007)
	end
end

UISoundController.instance = UISoundController.New()

return UISoundController
