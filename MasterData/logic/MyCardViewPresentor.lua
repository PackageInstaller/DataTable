-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/MyCardViewPresentor.lua

module("logic.extensions.roleinfo.view.MyCardViewPresentor", package.seeall)

local MyCardViewPresentor = class("MyCardViewPresentor", ViewWithGuidePresentor)

function MyCardViewPresentor:ctor()
	MyCardViewPresentor.super.ctor(self)
end

function MyCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MyCardViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/mycardview.prefab"
	}
end

function MyCardViewPresentor:buildViews()
	return {
		MyCardView.New()
	}
end

function MyCardViewPresentor:getTempResources()
	if RoleModel.instance.curCardInfo.gender == 0 then
		local avatarMo = DressModel.instance:getDefaultAvatarMo(DressModel.defaultFemaleSkelId or DressModel.defaultMaleSkelId)

		return avatarMo:getAssetsList(AvatarType.UI)
	end
end

function MyCardViewPresentor:_onVisualEvent(name)
	MyCardViewPresentor.super._onVisualEvent(self, name)
	GlobalDispatcher:dispatch(GlobalNotify.onRoleVisualEvent, name)
end

return MyCardViewPresentor
