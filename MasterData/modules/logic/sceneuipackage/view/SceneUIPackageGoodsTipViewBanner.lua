-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageGoodsTipViewBanner.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageGoodsTipViewBanner", package.seeall)

local SceneUIPackageGoodsTipViewBanner = class("SceneUIPackageGoodsTipViewBanner", BaseView)

function SceneUIPackageGoodsTipViewBanner:onInitView()
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneUIPackageGoodsTipViewBanner:addEvents()
	return
end

function SceneUIPackageGoodsTipViewBanner:removeEvents()
	return
end

function SceneUIPackageGoodsTipViewBanner:_editableInitView()
	self._picItems = self:getUserDataTb_()

	for i = 1, 2 do
		self._picItems[i] = self:getUserDataTb_()
		self._picItems[i].simgScene = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic_" .. i)
		self._picItems[i].simgUI = gohelper.findChildSingleImage(self._picItems[i].simgScene.gameObject, "#simage_banner")
	end
end

function SceneUIPackageGoodsTipViewBanner:onOpen()
	self._actId = SceneUIPackageModel.instance:getActId()

	local packageCo = SceneUIPackageModel.instance:getPackageCo(self._actId)

	if packageCo then
		self._bgs = string.split(packageCo.chargeRes, "|")
		self._uis = string.split(packageCo.chargeUIRes, "|")

		local count = #self._bgs

		for i, item in pairs(self._picItems) do
			gohelper.setActive(item.gameObject, i <= count)

			if i <= count then
				if item.simgScene then
					local icon = self._bgs[i]

					if not string.nilorempty(icon) then
						item.simgScene:LoadImage(ResUrl.getSceneUIPackageIcon(icon))
					end
				end

				if item.simgUI then
					local icon = self._uis[i]

					if not string.nilorempty(icon) then
						item.simgUI:LoadImage(ResUrl.getMainSceneSwitchLangIcon(icon))
					end
				end
			end
		end
	end
end

function SceneUIPackageGoodsTipViewBanner:onClose()
	return
end

function SceneUIPackageGoodsTipViewBanner:onDestroyView()
	for _, item in pairs(self._picItems) do
		if item.simgScene then
			item.simgScene:UnLoadImage()
		end

		if item.simgUI then
			item.simgUI:UnLoadImage()
		end
	end
end

return SceneUIPackageGoodsTipViewBanner
