ReleaseMgr = oo.class();

local this = ReleaseMgr;

function this:FightRelease()
    self:ApplyRelease({"prefabs_uis","prefabs_characters","prefabs_effects","prefabs_scenes"});   
end

function this:UIRelease()
    self:ApplyRelease({"prefabs_uis","prefabs_spine","textures_bigs"});
end

function this:ApplyRelease(keys)
    CSAPI.ApplyReleaseForce(keys);
end

function this:ReleaseSound()
    --LogError("bbbbbbb");
    CSAPI.ReleaseSound();
end

return this;
