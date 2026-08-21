local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self.v_uiobjects.SkinMask:SetActive(false)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(cfg, index)
  self.v_buddy_id = cfg.BuddyId
  self.v_fashion_id = cfg.Id
  self.v_index = index
  self.v_uiobjects.CharBg:SetActive(true)
  self.v_uiobjects.HeroSkinIcon:SetActive(true)
  self.v_uiobjects.WeaponBg:SetActive(false)
  self.v_uiobjects.WeaponSkinIcon:SetActive(false)
  ResMgr:load_set_icon(self.v_uicompents.HeroSkinIcon_img, cfg.SpriteId, nil, true, self)
end

function ui:set_discount(gift_cfg)
  if not gift_cfg then
    self.v_uiobjects.DiscountBg:SetActive(false)
    return
  end
  local has_buy = FashionMgr:check_has_bought_fashion(self.v_fashion_id)
  local show_tag = gift_cfg.ShowTag
  self.v_uiobjects.DiscountBg:SetActive(show_tag and not has_buy)
  if not show_tag then
    return
  end
  local tag_cfg = ShareRes.create("recharge.gift_tag", gift_cfg.ShowTag)
  if tag_cfg.TagBgIcon == "" then
    self.v_uiobjects.DiscountBg:SetActive(false)
    return
  end
  ResMgr:load_set_icon(self.v_uicompents.DiscountBg_img, tag_cfg.TagBgIcon, nil, false)
  local lab = gift_cfg.Discount and string.format("%s%s", gift_cfg.Discount / 10, tag_cfg.Name) or tag_cfg.Name
  self.v_uicompents.DiscountText_txt.text = lab
end

function ui:set_mask()
  local has_buy = FashionMgr:check_has_bought_fashion(self.v_fashion_id)
  self.v_uiobjects.SkinMask:SetActive(not has_buy)
end

function ui:set_red()
end

function ui:get_index()
  return self.v_index
end

return ui
