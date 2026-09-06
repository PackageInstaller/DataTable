-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongplotstageView.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.ChuangkongplotstageView", package.seeall)

local ChuangkongplotstageView = class("ChuangkongplotstageView", FatherStageView)

function ChuangkongplotstageView:ctor()
	ChuangkongplotstageView.super.ctor(self)
end

function ChuangkongplotstageView:_onClickStart()
	GameUtil.saveUserData(ChuangkongcopyView.CHAPTER_KEY, self._chapterIndex)
	ChuangkongplotstageView.super._onClickStart(self)
end

return ChuangkongplotstageView
