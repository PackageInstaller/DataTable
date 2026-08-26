-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_LineItemBaseList.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_LineItemBaseList", package.seeall)

local V3a4_Chg_GameView_LineItemBaseList = class("V3a4_Chg_GameView_LineItemBaseList", V3a4_Chg_GameView_ObjItemListImpl)

function V3a4_Chg_GameView_LineItemBaseList:ctor(ctorParam)
	V3a4_Chg_GameView_LineItemBaseList.super.ctor(self, ctorParam)
end

function V3a4_Chg_GameView_LineItemBaseList:onDestroyView()
	V3a4_Chg_GameView_LineItemBaseList.super.onDestroyView(self)
end

return V3a4_Chg_GameView_LineItemBaseList
