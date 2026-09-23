function Refresh(cfg)
    if cfg and not IsNil(gameObject) then
        ResUtil.PetEmoji:Load(gameObject,cfg.icon);
    end
end