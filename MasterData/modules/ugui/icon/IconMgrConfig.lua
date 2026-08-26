-- chunkname: @modules/ugui/icon/IconMgrConfig.lua

module("modules.ugui.icon.IconMgrConfig", package.seeall)

local IconMgrConfig = _M

IconMgrConfig.UrlItemIcon = "ui/viewres/common/item/commonitemicon.prefab"
IconMgrConfig.UrlPropItemIcon = "ui/viewres/common/commonpropitem.prefab"
IconMgrConfig.UrlEquipIcon = "ui/viewres/common/item/commonequipicon.prefab"
IconMgrConfig.UrlHeroIcon = "ui/viewres/common/item/commonheroicon.prefab"
IconMgrConfig.UrlHeroIconNew = "ui/viewres/common/item/commonheroiconnew.prefab"
IconMgrConfig.UrlHeroItemNew = "ui/viewres/common/item/commonheroitemnew.prefab"
IconMgrConfig.UrlPlayerIcon = "ui/viewres/common/item/commonplayericon.prefab"
IconMgrConfig.UrlRedDotIcon = "ui/viewres/common/item/commonreddoticon.prefab"
IconMgrConfig.UrlRoomGoodsItemIcon = "ui/viewres/room/roomgoodsitem.prefab"
IconMgrConfig.UrlCommonTextMarkTop = "ui/viewres/common/item/commontextmarktop.prefab"
IconMgrConfig.UrlHeadIcon = "ui/viewres/common/item/commonheadicon.prefab"
IconMgrConfig.UrlCritterIcon = "ui/viewres/common/item/commoncrittericon.prefab"
IconMgrConfig.UrlIconTag = "ui/viewres/common/item/commonicontag.prefab"

function IconMgrConfig.getPreloadList()
	return {
		IconMgrConfig.UrlItemIcon,
		IconMgrConfig.UrlPropItemIcon,
		IconMgrConfig.UrlEquipIcon,
		IconMgrConfig.UrlHeroIcon,
		IconMgrConfig.UrlHeroIconNew,
		IconMgrConfig.UrlHeroItemNew,
		IconMgrConfig.UrlPlayerIcon,
		IconMgrConfig.UrlRedDotIcon,
		IconMgrConfig.UrlHeadIcon,
		IconMgrConfig.UrlCritterIcon,
		IconMgrConfig.UrlIconTag
	}
end

IconMgrConfig.HeadIconType = {
	Static = 0,
	Dynamic = 1
}

return IconMgrConfig
