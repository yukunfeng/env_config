class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end

class Solution:
    """
    @param intervals: an array of meeting time intervals
    @return: the minimum number of conference rooms required
    """
    def minMeetingRooms(self, intervals):
        # Write your code here
        if not intervals:
            return 0

        import heapq
        intervals.sort(key=lambda x : x.start)
        heap_list = [intervals[0].end]
        heapq.heapify(heap_list)
        res = 1
        for i in range(1, len(intervals)):
            curr_interval = intervals[i]
            earliest_end = heapq.nsmallest(1, heap_list)
            # We cannot use previous room, allocate a new room
            if curr_interval.start < earliest_end:
                res += 1
                heapq.heappush(heap_list, curr_interval.end)
            else:
                # we use previous room, and update its ending time
                # question comes here: which one we use? doesn't matter on coming one?
                # how about if 2rd nsmallest is also a good choice?
                # or even do we really need to remove top one?
                heapq.heappop(heap_list)
                heapq.heappush(heap_list, curr_interval.end)
        return res

if __name__ == "__main__":
    solution = Solution()
    intervals = [Interval(0,30),Interval(5,10),Interval(15,20)]
    res = solution.minMeetingRooms(intervals)
