-- chunkname: @modules/logic/story/view/StoryViewMgr.lua

module("modules.logic.story.view.StoryViewMgr", package.seeall)

local StoryViewMgr = class("StoryViewMgr")

function StoryViewMgr:getStoryBackgroundView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:getStoryBlitEff()
	local go = self:getStoryBackgroundView()

	if not go then
		return
	end

	local blitGo = gohelper.findChild(go, "#go_blitbg")

	return (blitGo:GetComponent(typeof(UrpCustom.UIBlitEffect)))
end

function StoryViewMgr:getStoryBlitEffSecond()
	local go = self:getStoryBackgroundView()

	if not go then
		return
	end

	local blitSecondGo = gohelper.findChild(go, "#go_blitbgsecond")

	return (blitSecondGo:GetComponent(typeof(UrpCustom.UIBlitEffect)))
end

function StoryViewMgr:getStoryFrontBgGo()
	local bgRootGo = self:getStoryBackgroundView()

	if not bgRootGo then
		return nil
	end

	return (gohelper.findChild(bgRootGo, "#go_upbg"))
end

function StoryViewMgr:getStoryFrontBgImgGo()
	local frontBgGo = self:getStoryFrontBgGo()

	if not frontBgGo then
		return nil
	end

	return (gohelper.findChild(frontBgGo, "#simage_bgimg"))
end

function StoryViewMgr:getStoryHeroView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryHeroView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:setStoryHeroViewLayer(layer)
	local viewGo = self:getStoryHeroView()

	if not viewGo then
		return
	end

	gohelper.setLayer(viewGo, layer, true)
end

function StoryViewMgr:getStoryView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:setStoryViewLayer(layer)
	local viewGo = self:getStoryView()

	if not viewGo then
		return
	end

	gohelper.setLayer(viewGo, layer, true)
end

function StoryViewMgr:getStoryLeadRoleSpineView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:setStoryLeadRoleSpineViewLayer(layer)
	local viewGo = self:getStoryLeadRoleSpineView()

	if not viewGo then
		return
	end

	local maskGo = gohelper.findChild(viewGo, "#go_spineroot")

	gohelper.setLayer(maskGo, layer, true)
end

function StoryViewMgr:getStoryFrontView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:getStoryBottomBgGo()
	local bgRootGo = self:getStoryBackgroundView()

	if not bgRootGo then
		return nil
	end

	return gohelper.findChild(bgRootGo, "#go_bottombg")
end

function StoryViewMgr:getStoryBgImage()
	local imgGo = self:getStoryFrontBgImgGo()

	if not imgGo then
		return nil
	end

	return imgGo:GetComponent(gohelper.Type_Image)
end

function StoryViewMgr:getStoryBgImageTop()
	local imgGo = self:getStoryFrontBgImgGo()

	if not imgGo then
		return nil
	end

	local topGo = gohelper.findChild(imgGo, "#simage_bgtop")

	if not topGo then
		return nil
	end

	return topGo:GetComponent(gohelper.Type_Image)
end

function StoryViewMgr:getStoryBgCustomImage()
	local imgGo = self:getStoryFrontBgImgGo()

	if not imgGo then
		return nil
	end

	return imgGo:GetComponent(typeof(UnityEngine.UI.CustomImage))
end

function StoryViewMgr:getStoryBgBlurComp()
	local imgGo = self:getStoryFrontBgImgGo()

	if not imgGo then
		return nil
	end

	return imgGo:GetComponent(typeof(UrpCustom.UIGaussianEffect))
end

function StoryViewMgr:getStoryBgBlurGo()
	local imgGo = self:getStoryFrontBgImgGo()

	if not imgGo then
		return nil
	end

	return gohelper.findChild(imgGo, "#go_blur")
end

function StoryViewMgr:getStoryOldBgImage()
	local bottomGo = self:getStoryBottomBgGo()

	if not bottomGo then
		return nil
	end

	local oldGo = gohelper.findChild(bottomGo, "#simage_bgold")

	if not oldGo then
		return nil
	end

	return oldGo:GetComponent(gohelper.Type_Image)
end

function StoryViewMgr:getStoryOldBgImageTop()
	local bottomGo = self:getStoryBottomBgGo()

	if not bottomGo then
		return nil
	end

	local topGo = gohelper.findChild(bottomGo, "#simage_bgold/#simage_bgoldtop")

	if not topGo then
		return nil
	end

	return topGo:GetComponent(gohelper.Type_Image)
end

function StoryViewMgr:getStoryOldBgGo()
	local bottomGo = self:getStoryBottomBgGo()

	if not bottomGo then
		return nil
	end

	return gohelper.findChild(bottomGo, "#simage_bgold")
end

function StoryViewMgr:getStoryScreenTxtComp()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

	if not viewContainer then
		return nil
	end

	local frontView = viewContainer:getFrontView()

	if not frontView then
		return nil
	end

	local frontItem = frontView:getFrontItem()

	if not frontItem then
		return nil
	end

	return (frontItem:getCurScreenText())
end

StoryViewMgr.instance = StoryViewMgr.New()

return StoryViewMgr
