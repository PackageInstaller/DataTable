-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardDress2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardDress2026View", package.seeall)

local YearCardDress2026View = class("YearCardDress2026View", YearCardDress2023View)

function YearCardDress2026View:ctor()
	YearCardDress2023View.super.ctor(self)

	self._hasRes = true
end

function YearCardDress2026View:_getEffectPath()
	return "20251219/26nianfei/fx_ui_shizhuangjiemian_fw.prefab"
end

function YearCardDress2026View:onEnterFinished()
	if self._hasRes then
		YearCardDress2026View.super.onEnterFinished(self)
	end
end

return YearCardDress2026View
