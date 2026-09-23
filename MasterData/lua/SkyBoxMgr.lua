--天空盒管理
SkyBoxMgr = {};
local this = SkyBoxMgr;

--设置当前天空盒
function this:SetCurrSkyBox(go)
    if(self.currSkyBox == go)then
        return;
    end
    self.currSkyBox = go;
    EventMgr.Dispatch(EventType.SkyBox_Changed);
end
--获取当前天空盒
function this:GetCurrSkyBox()
    return self.currSkyBox;
end

return this;