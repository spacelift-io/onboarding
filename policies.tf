# ACCESS POLICY
#
# This example access policy gives everyone in the "Engineering" GitHub team
# read access to the stack.
#
# You can read more about access policies here:
#
# https://docs.spacelift.io/concepts/policy/stack-access-policy
resource "spacelift_policy" "access" {
  type = "ACCESS"

  name = "All of Engineering gets read access"
  body = file("${path.module}/policies/access.rego")
}

# Access policies only take effect when attached to the stack.
resource "spacelift_policy_attachment" "access" {
  policy_id = spacelift_policy.access.id
  stack_id  = data.spacelift_current_stack.this.id
}

# PLAN POLICY
#
# This example plan policy prevents you from creating weak passwords, and warns 
# you when passwords are meh.
#
# You can read more about plan policies here:
#
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy
resource "spacelift_policy" "plan" {
  type = "PLAN"

  name = "Enforce password strength"
  body = file("${path.module}/policies/plan.rego")
}

# Plan policies only take effect when attached to the stack.
resource "spacelift_policy_attachment" "plan" {
  policy_id = spacelift_policy.plan.id
  stack_id  = data.spacelift_current_stack.this.id
}

# PUSH POLICY
#
# This example Git push policy ignores all changes that are outside a project's
# root. Other than that, it follows the defaults - pushes to the tracked branch
# trigger tracked runs, pushes to all other branches trigger proposed runs, tag
# pushes are ignored.
#
# You can read more about push policies here:
#
# https://docs.spacelift.io/concepts/policy/git-push-policy
resource "spacelift_policy" "push" {
  type = "GIT_PUSH"

  name = "Ignore commits outside the project root"
  body = file("${path.module}/policies/push.rego")
}

# Push policies only take effect when attached to the stack.
resource "spacelift_policy_attachment" "push" {
  policy_id = spacelift_policy.push.id
  stack_id  = data.spacelift_current_stack.this.id
}
