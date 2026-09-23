local  this = {};

--获取队伍的FireBall层
this.GetTeamFireBallLayerName = CS.LayerUtil.GetTeamFireBallLayerName;
--获取队伍的Only层
this.GetTeamOnlyLayerName = CS.LayerUtil.GetTeamOnlyLayerName;

--获取队伍层名称
--GetTeamLayerName(int teamID)
this.GetTeamLayerName = CS.LayerUtil.GetTeamLayerName;

--获取队伍层
--GetTeamLayerName(int teamID)
this.GetTeamLayer = CS.LayerUtil.GetTeamLayer;

--将target对象层设置为teamID队伍的FireBall层
--SetTeamFireBallLayer(int teamID, GameObject target)
--将target对象层设置为origin对象的FireBall层
--SetTeamFireBallLayer(GameObject origin, GameObject target)
this.SetTeamFireBallLayer = CS.LayerUtil.SetTeamFireBallLayer;

--将target对象层设置为origin对象的Only层
--SetTeamOnlyLayer(GameObject origin, GameObject target)
this.SetTeamOnlyLayer = CS.LayerUtil.SetTeamOnlyLayer;

return this;