-- chunkname: @modules/logic/story/define/StoryViewDefine.lua

module("modules.logic.story.define.StoryViewDefine", package.seeall)

local StoryViewDefine = {}

function StoryViewDefine.init(module_views)
	module_views.StoryView = {
		destroy = 0,
		container = "StoryViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/story/view/storyview.prefab",
		layer = "POPUP_SECOND",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			AvProMgrConfig.UrlStoryVideo,
			AvProMgrConfig.UrlStoryVideoCompatible,
			[3] = "ui/viewres/story/view/storyslidedialog.prefab",
			[4] = AvProMgrConfig.UrlVideoDisable
		}
	}
	module_views.StoryLeadRoleSpineView = {
		destroy = 0,
		container = "StoryLeadRoleSpineViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/story/view/storyleadrolespineview.prefab",
		layer = "POPUPBlur",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {}
	}
	module_views.StoryLogView = {
		container = "StoryLogViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/story/view/storylogview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/story/view/storylogitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.StoryBranchView = {
		destroy = 0,
		container = "StoryBranchViewContainer",
		mainRes = "ui/viewres/story/view/storybranchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {}
	}
	module_views.StoryFrontView = {
		container = "StoryFrontViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/story/view/storyfrontview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/story/view/storyshake.prefab"
		}
	}
	module_views.StoryBackgroundView = {
		destroy = 0,
		container = "StoryBackgroundViewContainer",
		mainRes = "ui/viewres/story/view/storybackgroundview.prefab",
		layer = "POPUP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/story/view/storyrightmove.prefab",
			[2] = "ui/viewres/story/view/storyleftmove.prefab"
		}
	}
	module_views.StoryHeroView = {
		destroy = 0,
		container = "StoryHeroViewContainer",
		mainRes = "ui/viewres/story/view/storyheroview.prefab",
		layer = "POPUP_SECOND",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.StorySceneView = {
		destroy = 0,
		container = "StorySceneViewContainer",
		mainRes = "ui/viewres/story/view/storysceneview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.StoryTyperView = {
		destroy = 0,
		container = "StoryTyperViewContainer",
		mainRes = "ui/viewres/story/view/storytyperview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.StoryPrologueSkipView = {
		destroy = 0,
		container = "StoryPrologueSkipViewContainer",
		mainRes = "ui/viewres/story/view/storyprologueskipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.StoryHeroPreview = {
		destroy = 0,
		container = "StoryHeroPreviewContainer",
		mainRes = "ui/viewres/story/view/storyheropreview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	}
	module_views.StoryFullScreenStormView = {
		destroy = 0,
		container = "StoryFullScreenStormViewContainer",
		mainRes = "ui/viewres/story/stormcountdownview.prefab",
		layer = "POPUP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.V3A9StoryScoreCardView = {
		destroy = 0,
		container = "V3A9StoryScoreCardViewContainer",
		mainRes = "ui/viewres/story/v3a9_avgscoreview.prefab",
		layer = "POPUP",
		viewType = ViewType.Normal
	}
end

return StoryViewDefine
