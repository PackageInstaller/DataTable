--战斗剧情

FightActionPlot = oo.class(FightActionBase);
local this = FightActionPlot;

function this:OnPlay()
    PlotMgr:TryPlay(self.data.storyID,self.OnPlayCallBack,self);
end

function this:OnPlayCallBack()
    ReleaseMgr:ApplyRelease({"textures_bigs"});--释放掉剧情加载的大图资源

    self:Complete();

    FuncUtil:Call(FightClient.InitSpeed,FightClient,50);--防止崛起还原速度
end

return this;
