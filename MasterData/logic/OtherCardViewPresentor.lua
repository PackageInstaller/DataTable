-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/OtherCardViewPresentor.lua

module("logic.extensions.roleinfo.view.OtherCardViewPresentor", package.seeall)

local OtherCardViewPresentor = class("OtherCardViewPresentor", ViewPresentor)

function OtherCardViewPresentor:ctor()
	OtherCardViewPresentor.super.ctor(self)
end

function OtherCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OtherCardViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/othercardview.prefab"
	}
end

function OtherCardViewPresentor:buildViews()
	return {
		OtherCardView.New()
	}
end

function OtherCardViewPresentor:getTempResources()
	if RoleModel.instance.curCardInfo.gender == 0 then
		local avatarMo = DressModel.instance:getDefaultAvatarMo(DressModel.defaultFemaleSkelId or DressModel.defaultMaleSkelId)

		return avatarMo:getAssetsList(AvatarType.UI)
	end
end

function OtherCardViewPresentor:_onVisualEvent(name)
	OtherCardViewPresentor.super._onVisualEvent(self, name)
	GlobalDispatcher:dispatch(GlobalNotify.onRoleVisualEvent, name)
end

return OtherCardViewPresentor
