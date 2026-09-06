-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolFakeProgressViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolFakeProgressViewPresentor", package.seeall)

local MagicSchoolFakeProgressViewPresentor = class("MagicSchoolFakeProgressViewPresentor", ViewPresentor)

function MagicSchoolFakeProgressViewPresentor:ctor()
	MagicSchoolFakeProgressViewPresentor.super.ctor(self)
end

function MagicSchoolFakeProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolFakeProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolfakeprogressview.prefab"
	}
end

function MagicSchoolFakeProgressViewPresentor:buildViews()
	return {
		MagicSchoolFakeProgressView.New()
	}
end

return MagicSchoolFakeProgressViewPresentor
