#include <vector>

int main()
{
  std::vector<int> a(100,33);
  return a.capacity() - 100;
}
