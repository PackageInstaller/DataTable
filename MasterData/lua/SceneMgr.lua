--场景管理
local this = {};

function this:SetCurrScene(cfgScene,isLoaded)
    self.isLoaded = isLoaded;
    self.currScene = cfgScene;
end
function this:GetCurrScene()
    return self.currScene;
end

function this:IsLoaded()
    return self.isLoaded;
end

--是否主界面场景
function this:IsMajorCity()
    local cfgScene = self:GetCurrScene();
    return cfgScene and cfgScene.key == self:GetMajorCityKey();
end

--是否格子副本中
function this:IsBattleDungeon()
    local cfgScene = self:GetCurrScene();
    return cfgScene and cfgScene.key == "Battle";
end

function this:GetMajorCityKey()
    self.keyMajorCity = self.keyMajorCity or "MajorCity";
    return self.keyMajorCity;
end

--是否登陆后第一次loading
function this:SetLoginLoaded(isloading)
    self.isLoginLoading=isloading;
end

function this:IsLoginLoading()
    return self.isLoginLoading;
end

--是否秘境探索副本中
function this:IsRogueMapDungeon()
    local cfgScene = self:GetCurrScene();
    return cfgScene and cfgScene.key == "RogueMap";
end

return this;