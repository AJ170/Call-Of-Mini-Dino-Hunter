using BehaviorTree;
using UnityEngine;

public class doMoveToPlayerTask : Task
{
    protected Vector3 m_v3Src;

    protected Vector3 m_v3Dst;

    protected float m_fRate;

    protected bool m_bNeedNextPoint;

    public doMoveToPlayerTask(Node node)
        : base(node)
    {
        m_bNeedNextPoint = true;
    }

    public override void OnEnter(Object inputParam)
    {
        CCharPlayer cCharPlayer = inputParam as CCharPlayer;
        if (!(cCharPlayer == null))
        {
        }
    }

    public override void OnExit(Object inputParam)
    {
        CCharPlayer cCharPlayer = inputParam as CCharPlayer;
        if (!(cCharPlayer == null))
        {
        }
    }

    public override kTreeRunStatus OnUpdate(Object inputParam, float deltaTime)
    {
        CCharPlayer cCharPlayer = inputParam as CCharPlayer;
        if (cCharPlayer == null)
            return kTreeRunStatus.Failture;

        if (!cCharPlayer.hasTarget)
            return kTreeRunStatus.Executing;

        // Interpolate position toward targetPosition
        float speed = 5.5f; // Adjust this speed to fit your game
        cCharPlayer.Pos = Vector3.MoveTowards(cCharPlayer.Pos, cCharPlayer.targetPosition, speed * deltaTime);

        Vector3 moveDir = (cCharPlayer.targetPosition - cCharPlayer.Pos).normalized;
        cCharPlayer.UpdateMoveAnim(moveDir, cCharPlayer.ShootDir);

        // If close enough to target, stop moving
        if (Vector3.Distance(cCharPlayer.Pos, cCharPlayer.targetPosition) < 0.1f)
        {
            cCharPlayer.Pos = cCharPlayer.targetPosition;
            cCharPlayer.hasTarget = false;
            cCharPlayer.StopMoveAnim();
            return kTreeRunStatus.Success;
        }

        return kTreeRunStatus.Executing;
    }

}
