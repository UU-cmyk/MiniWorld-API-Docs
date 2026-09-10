--- @class ErrorCode @错误码
--- @field OK number @正确返回
--- @field FAILED number @错误返回
local ErrorCode = {}
_G.ErrorCode = ErrorCode

--- @class WorldType @游戏模式
--- @field OWTYPE_SINGLE number @单人模式
--- @field OWTYPE_CREATE number @多人创造模式
--- @field OWTYPE_EXTREMITY number @极限模式
--- @field OWTYPE_CREATE_RUNGAME number @由创造模式转的生存
--- @field OWTYPE_GAMEMAKER number @自制玩法的编辑模式
--- @field OWTYPE_GAMEMAKER_RUN number @自制玩法的运行模式
--- @field OWTYPE_FREEMODE number @冒险模式之自由模式
--- @field OWTYPE_RECORD number @录像模式
local WorldType = {}
_G.WorldType = WorldType

--- @class TerrainType @游戏地形
--- @field TERRAIN_FLAT number @平坦地形
--- @field TERRAIN_NORMAL number @随机地形
local TerrainType = {}
_G.TerrainType = TerrainType

--- @class CameraEditState @自定义视角编辑状态
--- @field CAMERA_EDIT_STATE_NULL number @空
--- @field CAMERA_EDIT_STATE_EDIT number @编辑
--- @field CAMERA_EDIT_STATE_TEST number @测试
local CameraEditState = {}
_G.CameraEditState = CameraEditState

--- @class MAPMARK_TYPE @小地图绘图类型
--- @field MMARK_LINE number @线形标记
--- @field MMARK_RECTANGLE number @矩形标记
--- @field MMARK_CIRCLE number @圆形标记
local MAPMARK_TYPE = {}
_G.MAPMARK_TYPE = MAPMARK_TYPE

--- @class EQUIP_SLOT_TYPE @装备部位类型
--- @field EQUIP_HEAD number @头
--- @field EQUIP_BREAST number @身体
--- @field EQUIP_LEGGING number @腿
--- @field EQUIP_SHOE number @脚
--- @field EQUIP_PIFENG number @披风
--- @field EQUIP_WEAPON number @武器
--- @field MAX_EQUIP_SLOTS number @最大装备栏
local EQUIP_SLOT_TYPE = {}
_G.EQUIP_SLOT_TYPE = EQUIP_SLOT_TYPE

--- @class MODATTRIB_TYPE @附魔属性类型
--- @field MODATTR_MOVE_SPEED number @移动速度
--- @field MODATTR_SWIM_SPEED number @游泳速度
--- @field MODATTR_JUMP_SPEED number @往上跳的速度
--- @field MODATTR_ATTACK_PUNCH number @近程攻击别人时加成的百分比
--- @field MODATTR_ATTACK_RANGE number @远程攻击别人时加成的百分比
--- @field MODATTR_ATTACK_EXPLODE number @爆炸攻击别人时加成的百分比
--- @field MODATTR_ATTACK_FIRE number @火攻击别人时加成的百分比
--- @field MODATTR_ATTACK_POISON number @毒攻击别人时加成的百分比
--- @field MODATTR_ATTACK_WITHER number @混乱攻击别人时加成的百分比
--- @field MODATTR_ATTACK_PLAYER number @攻击玩家时加成的百分比
--- @field MODATTR_ATTACK_UNDEAD number @攻击亡灵时加成的百分比
--- @field MODATTR_ATTACK_ANIMAL number @攻击动物别人时加成的百分比
--- @field MODATTR_DAMAGED_PUNCH number @被近程攻击时加成的百分比
--- @field MODATTR_DAMAGED_RANGE number @被远程攻击时加成的百分比
--- @field MODATTR_DAMAGED_EXPLODE number @被爆炸攻击时加成的百分比
--- @field MODATTR_DAMAGED_FIRE number @被火攻击时加成的百分比
--- @field MODATTR_DAMAGED_POISON number @被毒攻击时加成的百分比
--- @field MODATTR_DAMAGED_WITHER number @被混乱攻击时加成的百分比
--- @field MODATTR_DAMAGED_FALLING number @高处掉下伤害加成的百分比
--- @field MODATTR_ARMOR_PUNCH number @近程护甲加点
--- @field MODATTR_ARMOR_RANGE number @远程护甲加点
--- @field MODATTR_ARMOR_EXPLODE number @爆炸护甲加点
--- @field MODATTR_DAMAGE_ABSORB number @吸收伤害
--- @field MODATTR_CRITICAL_HIT number @暴击伤害加成
--- @field MODATTR_KNOCK number @增加攻击别人的击退距离
--- @field MODATTR_KNOCK_RESIST number @减少击退距离
--- @field MODATTR_KNOCK_RESIST_PROB number @击退概率抵抗值, 0.2表示有20%概率不被击退
--- @field MODATTR_ACTOR_SCALE number @角色大小 0 - 1.0 只针对玩家对象有效
--- @field MODATTR_DIG_SPEED number @挖掘速度
--- @field MODATTR_LUCK_DIG number @挖掘幸运, 0.2表示增加20%掉落概率
--- @field MODATTR_LUCK_KILLMOB number @怪物掉落
--- @field MODATTR_VIEW_BRIGHT number @视野亮度 0 - 1.0
--- @field MODATTR_OXYGEN_SUPPLY number @氧气提供
--- @field MAX_MOB_MODATTR number @怪物最大附魔属性
--- @field MAX_MOD_ATTRIB number @最大附魔属性
--- @field MAX_PLAYER_MODATTR number @玩家最大附魔属性
local MODATTRIB_TYPE = {}
_G.MODATTRIB_TYPE = MODATTRIB_TYPE

--- @class TEAM_RESULTS @游戏战斗结果
--- @field TEAM_RESULTS_NONE number @胜负未定
--- @field TEAM_RESULTS_WIN number @胜利
--- @field TEAM_RESULTS_LOSE number @失败
--- @field TEAM_RESULTS_DOGFALL number @平局
local TEAM_RESULTS = {}
_G.TEAM_RESULTS = TEAM_RESULTS

--- @class GSOUND_TYPE @声音类型
--- @field GSOUND_DIG number @挖掘
--- @field GSOUND_DESTROY number @破坏
--- @field GSOUND_PLACE number @放置
--- @field GSOUND_FALLGROUND number @摔落
--- @field GSOUND_WALK number @行走
local GSOUND_TYPE = {}
_G.GSOUND_TYPE = GSOUND_TYPE

--- @class ACTORBODY_EFFECT @生物身体特效
--- @field BODYFX_HURT number @受伤
--- @field BODYFX_FIRE number @燃烧
--- @field BODYFX_PORTAL number @传送门
--- @field BODYFX_ACCUMFIRE number @火焰累积
--- @field BODYFX_DRAGONFIRE number @龙焰
--- @field BODYFX_DRAGONSUMMON number @龙召唤
--- @field BODYFX_TAME_SUCCEED number @驯服成功
--- @field BODYFX_TAME_FAILED number @驯服失败
--- @field BODYFX_TAME_FOOD number @驯服食物
--- @field BODYFX_TAME_NOFOOD number @无驯服食物
--- @field BODYFX_AI_NEEDREEDS number @AI需要物品
--- @field BODYFX_FEAR number @恐惧
--- @field BODYFX_ROLECOLLECT number @角色收集
--- @field BODYFX_ROLEJUMP number @角色跳跃
--- @field BODYFX_DEADPROTECT number @死亡保护
--- @field BODYFX_DRAGONDIE0 number @龙死亡0
--- @field BODYFX_DRAGONDIE1 number @龙死亡1
--- @field BODYFX_DRAGONDIE2 number @龙死亡2
--- @field BODYFX_HORSE_FLY number @马飞行
--- @field BODYFX_DISAPPEAR number @消失
--- @field BODYFX_HORSE_BENTENG number @马奔腾
--- @field BODYFX_DANCE number @跳舞
--- @field TOOLFX_JETPACK2 number @喷气背包
--- @field BODYFX_INTERACTION number @交互
--- @field HUDFX_HEADSHOT number @爆头
--- @field HUDFX_NORMALSHOT number @普通射击
--- @field BODYFX_MILKING number @挤奶
--- @field BODYFX_AI_ANGRY number @AI愤怒
--- @field BODYFX_AI_SLEEP number @AI睡眠
--- @field BODYFX_TRANSPORT number @运输
--- @field BODYFX_FORBIDDEN number @禁止
--- @field BODYFX_CONCEAL number @潜行
--- @field BODYFX_WEAPON_FIRE number @野人猎手武器上的火
--- @field BODYFX_DIZZY number @眩晕
--- @field BODYFX_MAKETROUBLE number @捣乱
--- @field BODYFX_TRAINMOVE number @火车移动
--- @field BODYFX_AI_HUNGRY number @饥饿
--- @field BODYFX_BALL_CHARGE number @蓄力踢球特效
--- @field BODYFX_BALL_SHOOT_RELEASE number @射球瞬间爆发特效
--- @field BODYFX_ENCH_FALL number @附魔速降
local ACTORBODY_EFFECT = {}
_G.ACTORBODY_EFFECT = ACTORBODY_EFFECT

--- @class OBJ_TYPE @游戏实例类型
--- @field OBJTYPE_PLAYER number @玩家
--- @field OBJTYPE_CREATURE number @生物(包含怪物、动物、NPC、BOSS等)
--- @field OBJTYPE_DROPITEM number @掉落物
--- @field OBJTYPE_MISSILE number @投掷物
local OBJ_TYPE = {}
_G.OBJ_TYPE = OBJ_TYPE

--- @class BACKPACK_TYPE @玩家背包类型
--- @field SHORTCUT number @快捷栏
--- @field INVENTORY number @存储栏
--- @field EQUIP number @装备栏
local BACKPACK_TYPE = {}
_G.BACKPACK_TYPE = BACKPACK_TYPE

--- @class BPACK_SINDEX @存储栏起始位
--- @field BACKPACK_START_INDEX number @背包栏
--- @field SHORTCUT_START_INDEX number @快捷栏
--- @field STORAGE_START_INDEX number @储物箱
--- @field EQUIP_START_INDEX number @装备栏
local BPACK_SINDEX = {}
_G.BPACK_SINDEX = BPACK_SINDEX

--- @class FACE_DIRECTION @玩家朝向
--- @field DIR_NOT_INIT number @未指定
--- @field DIR_NEG_X number @X反方向
--- @field DIR_POS_X number @X正方向
--- @field DIR_NEG_Z number @Z反方向
--- @field DIR_POS_Z number @Z正方向
--- @field DIR_NEG_Y number @Y反方向
--- @field DIR_POS_Y number @Y正方向
local FACE_DIRECTION = {}
_G.FACE_DIRECTION = FACE_DIRECTION

--- @class CREATUREATTR @生物属性枚举
--- @field MAX_HP number @最大生命值
--- @field CUR_HP number @当前生命值
--- @field HP_RECOVER number @生命恢复
--- @field MAX_HUNGER number @最大饥饿值
--- @field CUR_HUNGER number @当前饥饿值
--- @field MAX_OXYGEN number @最大氧气值
--- @field CUR_OXYGEN number @当前氧气值
--- @field RECOVER_OXYGEN number @氧气恢复速度
--- @field WALK_SPEED number @移动速度
--- @field RUN_SPEED number @奔跑速度
--- @field SWIN_SPEED number @游泳速度
--- @field JUMP_POWER number @跳跃力
--- @field WEIGHT number @重量
--- @field DODGE number @闪避率
--- @field ATK_MELEE number @近战攻击
--- @field ATK_REMOTE number @远程攻击
--- @field DEF_MELEE number @近战防御
--- @field DEF_REMOTE number @远程防御
--- @field DIMENSION number @模型大小
--- @field ATK_PHYSICAL number @物理攻击
--- @field ATK_MAGIC number @元素攻击
--- @field DEF_PHYSICAL number @物理防御
--- @field DEF_MAGIC number @元素防御
--- @field ENABLE_MOVE number @可移动
--- @field ENABLE_ATTACK number @可攻击
--- @field ENABLE_BEATTACKED number @可被攻击
--- @field ENABLE_BEKILLED number @可被杀死
--- @field ENABLE_PICKUP number @可拾取道具
--- @field ENABLE_DEATHDROPITEM number @死亡掉落
local CREATUREATTR = {}
_G.CREATUREATTR = CREATUREATTR

--- @class PLAYERATTR @玩家属性枚举
--- @field MAX_HP number @最大生命值
--- @field CUR_HP number @当前生命值
--- @field HP_RECOVER number @生命恢复
--- @field LIFE_NUM number @生命数
--- @field MAX_HUNGER number @最大饥饿值
--- @field CUR_HUNGER number @当前饥饿值
--- @field MAX_OXYGEN number @最大氧气值
--- @field CUR_OXYGEN number @当前氧气值
--- @field RECOVER_OXYGEN number @氧气恢复速度
--- @field WALK_SPEED number @移动速度
--- @field RUN_SPEED number @奔跑速度
--- @field SNEAK_SPEED number @潜行速度
--- @field SWIN_SPEED number @游泳速度
--- @field JUMP_POWER number @跳跃力
--- @field DODGE number @闪避率
--- @field ATK_MELEE number @近战攻击
--- @field ATK_REMOTE number @远程攻击
--- @field DEF_MELEE number @近战防御
--- @field DEF_REMOTE number @远程防御
--- @field DIMENSION number @大小
--- @field SCORE number @分数
--- @field LEVEL number @星星等级
--- @field CUR_LEVELEXP number @当前经验
--- @field CUR_LEVEL number @当前等级
--- @field CUR_STRENGTH number @当前体力值
--- @field MAX_STRENGTH number @当前最大体力值
--- @field STRENGTH_RECOVER number @当前体力值恢复速度
--- @field ATK_PHYSICAL number @物理攻击
--- @field ATK_MAGIC number @元素攻击
--- @field DEF_PHYSICAL number @物理防御
--- @field DEF_MAGIC number @元素防御
--- @field ENABLE_MOVE number @可移动
--- @field ENABLE_PLACEBLOCK number @可摆放方块
--- @field ENABLE_OPERATEBLOCK number @可操作方块
--- @field ENABLE_DESTROYBLOCK number @可破坏方块
--- @field ENABLE_USEITEM number @可使用道具
--- @field ENABLE_ATTACK number @可攻击
--- @field ENABLE_BEATTACKED number @可被攻击
--- @field ENABLE_BEKILLED number @可被杀死
--- @field ENABLE_PICKUP number @可拾取道具
--- @field ENABLE_DEATHDROPITEM number @死亡掉落
--- @field ENABLE_VEHICLEAUTOFORWARD number @载具自动前行
--- @field ENABLE_DISCARDITEM number @可丢弃道具
--- @field ITEM_DISABLE_THROW number @道具不可丢弃
--- @field ITEM_DISABLE_DROP number @道具不可掉落
local PLAYERATTR = {}
_G.PLAYERATTR = PLAYERATTR

--- @class CREATUREMOTION @生物行为枚举
--- @field IDLE number @空闲
--- @field STANDBY number @待机
--- @field STROLL number @闲逛
--- @field ATK_MELEE number @近战攻击
--- @field ATK_REMOTE number @远程攻击
--- @field FOLLOW number @跟随
--- @field SWIM number @游泳
--- @field RUN_AWAY number @逃跑
--- @field SELF_BOMB number @自爆
--- @field BEATTRACTED number @被吸引
--- @field COPULATION number @交配
local CREATUREMOTION = {}
_G.CREATUREMOTION = CREATUREMOTION

--- @class PLAYERMOTION @玩家行为枚举
--- @field STATIC number @静止
--- @field WALK number @行走
--- @field RUN number @奔跑
--- @field JUMP number @跳跃
--- @field JUMP_TWICE number @二段跳
--- @field SNEAK number @潜行
--- @field FALL_GROUND number @落地
--- @field TURNBACK number @转身(已取消)
--- @field UP number @上升(已取消)
--- @field DOWN number @下降(已取消)
--- @field FALL number @下落(已取消)
local PLAYERMOTION = {}
_G.PLAYERMOTION = PLAYERMOTION

--- @class TEAMATTR @队伍属性枚举
--- @field PLAYER_NUM number @玩家数量
--- @field SCORE number @分数
local TEAMATTR = {}
_G.TEAMATTR = TEAMATTR

--- @class HURTTYPE @伤害类型枚举
--- @field MELEE number @近战伤害
--- @field REMOTE number @远程伤害
--- @field BOMB number @爆炸伤害
--- @field BURNING number @燃烧伤害
--- @field TOXIN number @毒素伤害
--- @field WITHER number @混乱伤害
--- @field SUN number @日晒
--- @field FALL number @跌落伤害
--- @field ANVIL number @被砸中伤害
--- @field CACTUS number @仙人掌伤害
--- @field ASPHYXIA number @窒息伤害
--- @field DROWN number @溺水伤害
--- @field SUFFOCATE number @水下生物在空气中窒息伤害
--- @field ANTIINJURY number @反伤
--- @field LASER number @被激光伤害
--- @field MAGIC number @元素伤害
--- @field PHYSICS number @物理伤害
local HURTTYPE = {}
_G.HURTTYPE = HURTTYPE

--- @class BLOCKATTR @方块属性枚举
--- @field EXPLODE_RESISTANCE number @爆炸抗性
--- @field HARDNESS number @硬度
--- @field GLISSADE number @滑行惯性
--- @field BURNING_SPEED number @燃烧速度
--- @field BURNING_PROBABILITY number @燃烧几率
--- @field LIGHTNESS number @亮度
--- @field ENABLE_DESTROYED number @可破坏
--- @field ENABLE_BEOPERATED number @可操作
--- @field ENABLE_BEPUSHED number @可被推动
--- @field ENABLE_DROPITEM number @可掉落道具
--- @field BEPUSHED_DROPITEM number @被推动掉落
local BLOCKATTR = {}
_G.BLOCKATTR = BLOCKATTR

--- @class BLOCKSTATUS @方块状态
--- @field ACTIVE number @活跃(被激活)
--- @field INACTIVE number @不活跃(未被激活)
local BLOCKSTATUS = {}
_G.BLOCKSTATUS = BLOCKSTATUS

--- @class WEATHERSTATUS @天气状态枚举
--- @field SHINE_AND_RAIN number @晴雨交替
--- @field SHINE number @晴天
--- @field RAIN number @雨天
local WEATHERSTATUS = {}
_G.WEATHERSTATUS = WEATHERSTATUS

--- @class VIEWPORTTYPE @视口方向
--- @field MAINVIEW number @主视角
--- @field BACKVIEW number @背视角
--- @field FRONTVIEW number @正视角
--- @field BACK2VIEW number @背视角2
--- @field TOPVIEW number @俯视角
--- @field CUSTOMVIEW number @自定义视角
local VIEWPORTTYPE = {}
_G.VIEWPORTTYPE = VIEWPORTTYPE

--- @class RESLIBTYPE @模板库类型
--- @field NONE number @无
--- @field BLOCK number @方块
--- @field ITEM number @道具
--- @field MONSTER number @生物
--- @field PARTICLE number @特效
--- @field SOUND number @音效
local RESLIBTYPE = {}
_G.RESLIBTYPE = RESLIBTYPE

--- @class GRAPHICS @图文信息枚举
--- @field GRAPHICS_HORNBOOK number @文字板
--- @field GRAPHICS_SUSPENDBOOK number @漂浮文字
--- @field GRAPHICS_PROGRESS number @进度条
--- @field GRAPHICS_ARROW_POS number @箭头指向位置
--- @field GRAPHICS_ARROW_ACTOR number @箭头指向生物
--- @field GRAPHICS_LINE_POS number @线指向位置
--- @field GRAPHICS_LINE_ACTOR number @线指向生物
--- @field GRAPHICS_SURFACE_POS number @面指向界面
--- @field GRAPHICS_SURFACE_ACTOR number @面指向生物
--- @field GRAPHICS_IMAGE number @图片
local GRAPHICS = {}
_G.GRAPHICS = GRAPHICS

--- @class FURNACEID @合成炉枚举
--- @field FURNACEID_STONE number @石炉
--- @field FURNACEID_IRON number @铁炉
--- @field FURNACEID_COPPER number @铜炉
local FURNACEID = {}
_G.FURNACEID = FURNACEID

--- @class STORAGEID @储物箱枚举
--- @field STORAGEID_BOX number @储物箱
--- @field STORAGEID_BOXROW number @大型储物箱（横）
--- @field STORAGEID_BOXCOL number @大型储物箱（竖）
local STORAGEID = {}
_G.STORAGEID = STORAGEID

--- @class SORT @排序枚举
--- @field UP number @升序
--- @field DOWN number @降序
local SORT = {}
_G.SORT = SORT

--- @class MOVETYPE @移动方式枚举
--- @field FLY number @飞行
--- @field IDLE number @默认移动方式
local MOVETYPE = {}
_G.MOVETYPE = MOVETYPE

--- @class EVENTDATE @设备时间类型枚举
--- @field YEAR number @年
--- @field MONTH number @月
--- @field DAY number @日
--- @field HOUR number @时
--- @field MINUTE number @分
--- @field SECOND number @秒
--- @field TIMESTAMP number @时间戳
local EVENTDATE = {}
_G.EVENTDATE = EVENTDATE

--- @class ITEMATTR @道具属性
--- @field ATTACK number @攻击力
--- @field STACKMAX number @叠加数
--- @field SHORTDEFENSE number @近战防御
--- @field LONGDEFENSE number @远程防御
--- @field EXPLODEDEFENSE number @爆炸防御
--- @field FIREDEFENSE number @燃烧防御
--- @field POISONDEFENSE number @毒素防御
--- @field WITHERDEFENSE number @混乱防御
--- @field DURATION number @耐久度
--- @field FIREINTERVAL number @射击间隔
--- @field MAGAZINES number @弹夹量
local ITEMATTR = {}
_G.ITEMATTR = ITEMATTR

--- @class DROPMODE @掉落物掉落方式
--- @field DISCARDITEM number @丢弃道具
--- @field DESTROYBOX number @箱子被破坏掉落
--- @field DEFEATMOB number @生物被击败掉落
--- @field DESTROYBLOCK number @方块被破坏掉落
--- @field SPAWNITEM number @触发器创建
--- @field CHANGEPLAYMODE number @掉落物对象转玩法创建
local DROPMODE = {}
_G.DROPMODE = DROPMODE

--- @class ANIMMODE @动作播放方式
--- @field ANIM_MODE_LOOP number @循环播放
--- @field ANIM_MODE_ONCE number @播放一次
--- @field ANIM_MODE_ONCE_STOP number @播放一次完毕,停在末尾
--- @field ANIM_MODE_DEFAULT number @表格默认值播放
local ANIMMODE = {}
_G.ANIMMODE = ANIMMODE

--- @class LinearTransformation @线性变换
--- @field None number @无动画
--- @field Linear number @直线变换
--- @field QuadIn number @平方曲线1渐入
--- @field QuadOut number @平方曲线2渐出
--- @field QuadInOut number @平方曲线3进出
--- @field ExpoIn number @指数曲线1渐入
--- @field ExpoOut number @指数曲线2渐出
--- @field ExpoInOut number @指数曲线3进出
--- @field CircIn number @圆曲线1渐入
--- @field CircOut number @圆曲线2渐出
--- @field CircInOut number @圆曲线3进出
--- @field ElasticIn number @弹簧曲线1渐入
--- @field ElasticOut number @弹簧曲线2渐出
--- @field ElasticInOut number @弹簧曲线3进出
--- @field BackIn number @回退曲线1渐入
--- @field BackOut number @回退曲线2渐出
--- @field BackInOut number @回退曲线3进出
--- @field BounceIn number @弹跳曲线1渐入
--- @field BounceOut number @弹跳曲线1渐出
--- @field BounceInOut number @弹跳曲线1进出
local LinearTransformation = {}
_G.LinearTransformation = LinearTransformation

--- @class SKYBOXMAP @天空盒贴图
--- @field SKYMAP number @天空贴图
--- @field SUNMAP number @太阳贴图
--- @field MOONMAP number @月亮贴图
local SKYBOXMAP = {}
_G.SKYBOXMAP = SKYBOXMAP

--- @class SKYBOXCOLOR @天空盒颜色
--- @field TOPCOLOR number @天空顶部颜色
--- @field MIDDLECOLOR number @天空腰部颜色
--- @field BOTTOMCOLOR number @天空底部颜色
--- @field LIGHTCOLOR number @天空光照颜色
--- @field ENVCOLOR number @环境光颜色
--- @field SUNCOLOR number @太阳颜色
--- @field MOONCOLOR number @月亮颜色
--- @field CLOUDCOLOR number @云颜色
--- @field FOGCOLOR number @雾颜色
local SKYBOXCOLOR = {}
_G.SKYBOXCOLOR = SKYBOXCOLOR

--- @class SKYBOXATTR @天空盒参数
--- @field SUNSCALE number @太阳大小
--- @field MOONSCALE number @月亮大小
--- @field STARDENSITY number @星星密度
--- @field CLOUDSPEED number @云的运动速度
--- @field CLOUDENSITY number @云的密度
--- @field CLOUDHIGH number @云的高度
--- @field FOGREMINDIS number @雾的最近距离
--- @field FOGREMAXDIS number @雾的最远距离
--- @field TEMPLATE number @模板
local SKYBOXATTR = {}
_G.SKYBOXATTR = SKYBOXATTR

--- @class SKYBOXPARTICLE @天空盒环境粒子参数
--- @field STRENGTH number @强度
--- @field RANGE number @范围
--- @field SPEED number @速度
--- @field RANDOMNESS number @运动不规则度
local SKYBOXPARTICLE = {}
_G.SKYBOXPARTICLE = SKYBOXPARTICLE

--- @class SKYBOXFILTER @天空盒滤镜参数
--- @field CONTRAST number @对比度
--- @field SATURATION number @饱和度
--- @field FLOOD number @泛光强度
--- @field EXPOSURE number @曝光强度
--- @field VOLUMELIGHT number @体积光强度
--- @field GAMMA number @伽马强度
--- @field DEPTH number @景深强度
--- @field COLOR number @滤镜颜色
--- @field LUT number @色彩校正
--- @field TEMPLATE number @滤镜模板
local SKYBOXFILTER = {}
_G.SKYBOXFILTER = SKYBOXFILTER

--- @class CameraModel @摄像机属性
--- @field MoveFollow number @跟随角色移动
--- @field RotateFollow number @跟随角色旋转
--- @field Autoindent number @阻挡后自动缩进
--- @field RelativeRotate number @相对人物旋转
--- @field RoleTranslucent number @角色半透
local CameraModel = {}
_G.CameraModel = CameraModel

--- @class CameraRotate @摄像机旋转模式
--- @field AllDir number @全方向
--- @field OnlyYaw number @仅左右
--- @field OnlyPitch number @仅上下
--- @field NoTurn number @无法转动
local CameraRotate = {}
_G.CameraRotate = CameraRotate

--- @class MiniShopPage @开发者商店页面类型
--- @field Item number @道具购买
--- @field Skin number @皮肤
--- @field Convert number @兑换
--- @field Welfare number @福利
--- @field MiniVip number @大会员
local MiniShopPage = {}
_G.MiniShopPage = MiniShopPage

--- @class QQMUSICOP @QQ音乐操作类型
--- @field PAUSE number @暂停
--- @field RESUME number @恢复
--- @field STOP number @停止
local QQMUSICOP = {}
_G.QQMUSICOP = QQMUSICOP

--- @class CurEventParam
--- @field EventDate EventDate

--- @class EventDate
--- @field time number @时间戳
--- @field year number @年
--- @field month number @月
--- @field day number @日
--- @field hour number @小时
--- @field minute number @分钟
--- @field second number @秒
local CurEventParam = {}
_G.CurEventParam = CurEventParam