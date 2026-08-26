-- chunkname: @modules/logic/defines/ViewAnim.lua

module("modules.logic.defines.ViewAnim", package.seeall)

local ViewAnim = _M

ViewAnim.Internal = "AnimInternal"
ViewAnim.Default = "Tween"
ViewAnim.CharacterLevelUpView = "ui/animations/dynamic/characterlevelupview.controller"
ViewAnim.CharacterLevelUpView2 = "ui/animations/dynamic/characterlevelupview2.controller"
ViewAnim.LvUpAnimPath = "ui/animations/dynamic/fightcard_rising.controller"
ViewAnim.LvDownAnimPath = "ui/animations/dynamic/fightcard_escending.controller"
ViewAnim.FightCardZaiXu = "ui/animations/dynamic/fightcarditem_zaixu.controller"
ViewAnim.FightCardBalance = "ui/animations/dynamic/fightcard_balance.controller"
ViewAnim.FightCardWuDuQuan = "ui/animations/dynamic/fightcarditem_wuduquan.controller"
ViewAnim.FightCardAppear = "ui/animations/dynamic/fightcard_appear.controller"

return ViewAnim
